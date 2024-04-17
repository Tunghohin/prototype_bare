#![allow(dead_code)]

use crate::bsp::config::*;

#[repr(align(4))]
#[derive(Copy, Clone)]
struct KernelStack {
    data: [u8; KERNEL_STACK_SIZE],
}

impl KernelStack {}

#[repr(align(4))]
#[derive(Copy, Clone)]
struct UserStack {
    data: [u8; USER_STACK_SIZE],
}

impl UserStack {}

static KERNEL_STACK: [KernelStack; MAX_TASK_NUM] = [KernelStack {
    data: [0; KERNEL_STACK_SIZE],
}; MAX_TASK_NUM];

static USER_STACK: [UserStack; MAX_TASK_NUM] = [UserStack {
    data: [0; USER_STACK_SIZE],
}; MAX_TASK_NUM];
