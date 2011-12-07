//
//  IceCream.m
//  IceCream
//
//  Created by Lucas Moreira on 15/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "IceCream.h"

@implementation IceCream
@synthesize delegate, simulating, initialSpace, finalSpace, initialVelocity, aceleration;

- (id)initWithRoadWidth:(float)road_width carWidth:(float)car_width {
    self = [super init];
    
    if (self) {
        roadWidth = road_width; // Comprimento da reta (pista/estrada).
        carWidth = car_width;   // Comprimento do corpo (carro).
    }
    
    return self;
}

- (void)recalculate {
    time += 0.1;
    
    // Tratando de MRU/MRUV (Movimento Retilíno Uniforme - variado ou não):
    // o que vai ser alterado, de acordo com a aceleração, será somente
    // a velocidade atual (que será acelerada) e o espaço final (que será mudado de acordo com a relação tempo x velocidade)
    
    
    // CALCULAR A POSIÇÃO ATUAL
    // Aplicamos a fórmula: Sf = S0 + V0t + (at²/2)
    currentPosition = initialSpace + (initialVelocity * time) + (aceleration * (time * time) / 2);
    //NSLog(@"currentPosition: %f", currentPosition);
    
    
    // CALCULAR A VELOCIDADE ATUAL
    // Aplicamos a fórmula: Vf = V0 + at
    currentVelocity = initialVelocity + (aceleration * time);
    //NSLog(@"currentVelocity: %f", currentVelocity);
    
    
    // Chamamos o delegate que será responsavel por "avisar" nossa ViewController
    // para atualizar a posição do carro
    if ([[self delegate] respondsToSelector:@selector(recalculatedForIceCream:position:velocity:time:)])
        [[self delegate] recalculatedForIceCream:self position:currentPosition velocity:currentVelocity time:time];
    
    
    // Checamos se o corpo (carro) chegou ao destino (Sf) e então paramos o loop
    if (currentPosition >= finalSpace) {
        [self stopLoop];
        
        currentPosition = 0;
        currentVelocity = 0;
        time = 0;
        
        if ([[self delegate] respondsToSelector:@selector(simulationDidFinish:)])
            [[self delegate] simulationDidFinish:self];
    }
}

- (void)startLoop {
    if (simulating) return;
    
    simulating = YES;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                             target:self
                                           selector:@selector(recalculate)
                                           userInfo:nil
                                            repeats:YES];
}

- (void)stopLoop {
    simulating = NO;
    
    [timer invalidate];
    timer = nil;
}

- (void)reset {
    [self stopLoop];
    
    currentPosition = 0;
    currentVelocity = 0;
    time = 0;
    
    if ([[self delegate] respondsToSelector:@selector(recalculatedForIceCream:position:velocity:time:)])
        [[self delegate] recalculatedForIceCream:self position:currentPosition velocity:currentVelocity time:time];
    
    if ([[self delegate] respondsToSelector:@selector(simulationDidFinish:)])
        [[self delegate] simulationDidFinish:self];
}

- (float)metersPerPixel {
    return (roadWidth - carWidth) / (finalSpace - initialSpace);
}

- (NSArray *)dataForGraphSpaceOverTime {
    NSMutableArray *result = [[[NSMutableArray alloc] init] autorelease];
    
    float lastPosition = initialSpace;
    int currentTime = 0;
    
    while (lastPosition <= finalSpace) {
        lastPosition = initialSpace + (initialVelocity * currentTime) + (aceleration * (currentTime * currentTime) / 2);
        
        NSDictionary *dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithInt:currentTime], [NSNumber numberWithFloat:lastPosition], nil]
                                                         forKeys:[NSArray arrayWithObjects:@"x", @"y", nil]];
        
        [result addObject:dict];        
        currentTime++;
    }

    return result;
}

- (NSArray *)dataForGraphVelocityOverTime {
    NSMutableArray *result = [[[NSMutableArray alloc] init] autorelease];
    
    float currentTime = 0;
    
    if (aceleration == 0) {
        // Movimento sem aceleração
        float maxTime = (finalSpace - initialSpace) / initialVelocity;
        
        while (currentTime <= maxTime) {            
            NSDictionary *dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithInt:currentTime], [NSNumber numberWithFloat:initialVelocity], nil]
                                                             forKeys:[NSArray arrayWithObjects:@"x", @"y", nil]];
            
            [result addObject:dict];
            currentTime++;
        }
        
    } else {
        float maxVelocity = sqrtf((initialVelocity * initialVelocity) + 2*aceleration*(finalSpace - initialSpace)); // Equação de Torricelli
        float lastVelocity = 0;
        
        while (lastVelocity <= maxVelocity) {
            lastVelocity = initialVelocity + (aceleration * currentTime);
            
            NSDictionary *dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithInt:currentTime], [NSNumber numberWithFloat:lastVelocity], nil]
                                                             forKeys:[NSArray arrayWithObjects:@"x", @"y", nil]];
            
            [result addObject:dict];
            currentTime++;
        }
    }
    
    return result;
}

@end
