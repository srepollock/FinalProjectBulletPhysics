//
//  BulletPhysics.m
//  BulletTest
//
//  Created by Borna Noureddin on 2015-03-20.
//  Copyright (c) 2015 BCIT. All rights reserved.
//

#import "BulletPhysics.h"
//#include "bullet-2.82-r2704/src/btBulletDynamicsCommon.h"
#include "btBulletDynamicsCommon.h"

@interface BulletPhysics()
{
    btBroadphaseInterface *broadphase;
    btDefaultCollisionConfiguration *collisionConfiguration;
    btCollisionDispatcher *dispatcher;
    btSequentialImpulseConstraintSolver *solver;
    btDiscreteDynamicsWorld *dynamicsWorld;
    btCollisionShape *groundShape;
    btCollisionShape *fallShape;
    btDefaultMotionState *groundMotionState;
    btRigidBody *groundRigidBody;
    btDefaultMotionState *fallMotionState;
    btRigidBody *fallRigidBody;
}

@end

@implementation BulletPhysics

- (instancetype)init
{
    self = [super init];
    if (self) {
        broadphase = new btDbvtBroadphase();
        collisionConfiguration = new btDefaultCollisionConfiguration();
        dispatcher = new btCollisionDispatcher(collisionConfiguration);
        solver = new btSequentialImpulseConstraintSolver;
        dynamicsWorld = new btDiscreteDynamicsWorld(dispatcher,broadphase,solver,collisionConfiguration);
        dynamicsWorld->setGravity(btVector3(0,-9.81,0));
        
        groundShape = new btStaticPlaneShape(btVector3(0,1,0),1);
        groundMotionState = new btDefaultMotionState(btTransform(btQuaternion(0,0,0,1),btVector3(0,1,0)));
        btRigidBody::btRigidBodyConstructionInfo
        groundRigidBodyCI(0,groundMotionState,groundShape,btVector3(0,0,0));
        groundRigidBody = new btRigidBody(groundRigidBodyCI);
        dynamicsWorld->addRigidBody(groundRigidBody);
        
        fallShape = new btSphereShape(1);
        // change this to start sphere in a different location
        fallMotionState = new btDefaultMotionState(btTransform(btQuaternion(0,0,0,1),btVector3(0,5,0)));
        btScalar mass = 1;
        btVector3 fallInertia(0,0,0);
        fallShape->calculateLocalInertia(mass,fallInertia);
        btRigidBody::btRigidBodyConstructionInfo fallRigidBodyCI(mass,fallMotionState,fallShape,fallInertia);
        fallRigidBodyCI.m_friction = 0.3;
        fallRigidBody = new btRigidBody(fallRigidBodyCI);
        fallRigidBody->setRestitution(0.1);
        dynamicsWorld->addRigidBody(fallRigidBody);
        
        NSLog(@"Starting bullet physics...\n");
        
        ballPos = Vector3();
        floorPos = Vector3();
    }
    return self;
}

- (void)dealloc
{
    dynamicsWorld->removeRigidBody(fallRigidBody);
    delete fallRigidBody->getMotionState();
    delete fallRigidBody;
    
    dynamicsWorld->removeRigidBody(groundRigidBody);
    delete groundRigidBody->getMotionState();
    delete groundRigidBody;
    
    
    delete fallShape;
    
    delete groundShape;
    
    
    delete dynamicsWorld;
    delete solver;
    delete collisionConfiguration;
    delete dispatcher;
    delete broadphase;
    NSLog(@"Ending bullet physics...\n");
}

-(void)Update:(float)elapsedTime
{
    dynamicsWorld->stepSimulation(1/60.f,10);
    btTransform trans;
    fallRigidBody->getMotionState()->getWorldTransform(trans);
    ballPos.x = trans.getOrigin().getX();
    ballPos.y = trans.getOrigin().getY();
    ballPos.z = trans.getOrigin().getZ();
    
    btVector3 velocity = fallRigidBody->getLinearVelocity();
    NSLog(@"position: %f, %f, %f", ballPos.x, ballPos.y, ballPos.z);
    NSLog(@"velocity: %f, %f, %f", velocity.x(), velocity.y(), velocity.z());
//    ballRotation -= velocity.x() / 30.0;
    
    groundRigidBody->getMotionState()->getWorldTransform(trans);
    floorPos.x = trans.getOrigin().getX();
    floorPos.y = trans.getOrigin().getY();
    floorPos.z = trans.getOrigin().getZ();
}


@end
