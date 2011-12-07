//
//  IceCream.h
//  IceCream
//
//  Created by Lucas Moreira on 15/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IceCream : NSObject {
    id delegate;

    NSTimer *timer;
    
    float roadWidth;
    float carWidth;
    float currentVelocity;
    float currentPosition;
    float initialSpace;
    float finalSpace;
    float initialVelocity;
    float aceleration;
    float time;
    
    BOOL simulating;
}

@property (strong, nonatomic) id delegate;
@property (assign) float initialSpace;
@property (assign) float finalSpace;
@property (assign) float initialVelocity;
@property (assign) float aceleration;
@property (nonatomic, getter = isSimulating) BOOL simulating;

// Inicialização do objeto.
- (id)initWithRoadWidth:(float)road_with carWidth:(float)car_width;

// Recalcula tudo. Geralmente, em loop.
- (void)recalculate;

// Reseta o movimento
- (void)reset;

// Inicializa e finaliza o loop até o corpo chegar a seu espaço final
- (void)startLoop;
- (void)stopLoop;

// Calcula a razão PIXEL x METROS. 
- (float)metersPerPixel;

// Gráficos
- (NSArray *)dataForGraphSpaceOverTime;
- (NSArray *)dataForGraphVelocityOverTime;

@end

@protocol IceCreamDelegate <NSObject>
- (void)recalculatedForIceCream:(IceCream *)iceCream position:(float)position velocity:(float)velocity time:(float)time;
- (void)simulationDidFinish:(IceCream *)iceCream;
@end