;******************************************************************************
;* File Name          : startup_stm32g0b1xx.s
;* Author             : MCD Application Team
;* Description        : STM32G0b1xx devices vector table for MDK-ARM toolchain.
;*                      This module performs:
;*                      - Set the initial SP
;*                      - Set the initial PC == Reset_Handler
;*                      - Set the vector table entries with the exceptions ISR address
;*                      - Branches to __main in the C library (which eventually
;*                        calls main()).
;*                      After Reset the CortexM0 processor is in Thread mode,
;*                      priority is Privileged, and the Stack is set to Main.
;* <<< Use Configuration Wizard in Context Menu >>>
;******************************************************************************
;* @attention
;*
;* Copyright (c) 2020 STMicroelectronics.
;* All rights reserved.
;*
;* This software is licensed under terms that can be found in the LICENSE file
;* in the root directory of this software component.
;* If no LICENSE file comes with this software, it is provided AS-IS.
;*
;******************************************************************************

; Amount of memory (in bytes) allocated for Stack
; Tailor this value to your application needs
; <h> Stack Configuration
;   <o> Stack Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Stack_Size		EQU     0x200

                AREA    STACK, NOINIT, READWRITE, ALIGN=3
Stack_Mem       SPACE   Stack_Size
__initial_sp


; <h> Heap Configuration
;   <o>  Heap Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Heap_Size      EQU     0x7000

                AREA    HEAP, NOINIT, READWRITE, ALIGN=3
__heap_base
Heap_Mem        SPACE   Heap_Size
__heap_limit

                PRESERVE8
                THUMB


; Vector Table Mapped to Address 0 at Reset
                AREA    RESET, DATA, READONLY
                EXPORT  __Vectors
                EXPORT  __Vectors_End
                EXPORT  __Vectors_Size

__Vectors       DCD     __initial_sp                   ; Top of Stack
                DCD     Reset_Handler                  ; Reset Handler
                DCD     NMI_Handler                    ; NMI Handler
                DCD     HardFault_Handler              ; Hard Fault Handler
                DCD     0                              ; Reserved
                DCD     0                              ; Reserved
                DCD     0                              ; Reserved
                DCD     0                              ; Reserved
                DCD     0                              ; Reserved
                DCD     0                              ; Reserved
                DCD     0                              ; Reserved
                DCD     SVC_Handler                    ; SVCall Handler
                DCD     0                              ; Reserved
                DCD     0                              ; Reserved
                DCD     PendSV_Handler                 ; PendSV Handler
                DCD     SysTick_Handler                ; SysTick Handler

                ; External Interrupts
                DCD     WWDG_IRQHandler                ; Window Watchdog
                DCD     PVD_VDDIO2_IRQHandler          ; PVD through EXTI Line detect
                DCD     RTC_TAMP_IRQHandler            ; RTC through EXTI Line
                DCD     FLASH_IRQHandler               ; FLASH
                DCD     RCC_CRS_IRQHandler             ; RCC & CRS
                DCD     EXTI0_1_IRQHandler             ; EXTI Line 0 and 1
                DCD     EXTI2_3_IRQHandler             ; EXTI Line 2 and 3
                DCD     EXTI4_15_IRQHandler            ; EXTI Line 4 to 15
                DCD     USB_UCPD1_2_IRQHandler         ; USB, UCPD1 & UCPD2
                DCD     DMA1_Channel1_IRQHandler       ; DMA1 Channel 1
                DCD     DMA1_Channel2_3_IRQHandler     ; DMA1 Channel 2 and Channel 3
                DCD     DMA1_Ch4_7_DMA2_Ch1_5_DMAMUX1_OVR_IRQHandler ; DMA1 Ch4 to Ch7, DMA2 Ch1 to Ch5 ,DMAMUX1 overrun
                DCD     ADC1_COMP_IRQHandler           ; ADC1, COMP1, COMP2 and COMP3 
                DCD     TIM1_BRK_UP_TRG_COM_IRQHandler ; TIM1 Break, Update, Trigger and Commutation
                DCD     TIM1_CC_IRQHandler             ; TIM1 Capture Compare
                DCD     TIM2_IRQHandler                ; TIM2
                DCD     TIM3_TIM4_IRQHandler           ; TIM3, TIM4
                DCD     TIM6_DAC_LPTIM1_IRQHandler     ; TIM6, DAC & LPTIM1
                DCD     TIM7_LPTIM2_IRQHandler         ; TIM7 & LPTIM2
                DCD     TIM14_IRQHandler               ; TIM14
                DCD     TIM15_IRQHandler               ; TIM15
                DCD     TIM16_FDCAN_IT0_IRQHandler     ; TIM16 & FDCAN1_IT0 & FDCAN2_IT0
                DCD     TIM17_FDCAN_IT1_IRQHandler     ; TIM17 & FDCAN1_IT1 & FDCAN2_IT1
                DCD     I2C1_IRQHandler                ; I2C1
                DCD     I2C2_3_IRQHandler              ; I2C2, I2C3
                DCD     SPI1_IRQHandler                ; SPI1
                DCD     SPI2_3_IRQHandler              ; SPI2, SPI3
                DCD     USART1_IRQHandler              ; USART1
                DCD     USART2_LPUART2_IRQHandler      ; USART2 & LPUART2
                DCD     USART3_4_5_6_LPUART1_IRQHandler ; USART3, USART4, USART5, USART6, LPUART1
                DCD     CEC_IRQHandler                 ; CEC

__Vectors_End

__Vectors_Size  EQU  __Vectors_End - __Vectors

                AREA    |.text|, CODE, READONLY

; Reset handler routine
Reset_Handler    PROC
                 EXPORT  Reset_Handler                 [WEAK]
        IMPORT  __main
        IMPORT  SystemInit  
                 LDR     R0, =SystemInit
                 BLX     R0
                 LDR     R0, =__main
                 BX      R0
                 ENDP

; Dummy Exception Handlers (infinite loops which can be modified)

NMI_Handler     PROC
                EXPORT  NMI_Handler                    [WEAK]
                B       .
                ENDP
HardFault_Handler\
                PROC
                EXPORT  HardFault_Handler              [WEAK]
                B       .
                ENDP
SVC_Handler     PROC
                EXPORT  SVC_Handler                    [WEAK]
                B       .
                ENDP
PendSV_Handler  PROC
                EXPORT  PendSV_Handler                 [WEAK]
                B       .
                ENDP
SysTick_Handler PROC
                EXPORT  SysTick_Handler                [WEAK]
                B       .
                ENDP

Default_Handler PROC

                EXPORT  WWDG_IRQHandler                [WEAK]
                EXPORT  PVD_VDDIO2_IRQHandler          [WEAK]
                EXPORT  RTC_TAMP_IRQHandler            [WEAK]
                EXPORT  FLASH_IRQHandler               [WEAK]
                EXPORT  RCC_CRS_IRQHandler             [WEAK]
                EXPORT  EXTI0_1_IRQHandler             [WEAK]
                EXPORT  EXTI2_3_IRQHandler             [WEAK]
                EXPORT  EXTI4_15_IRQHandler            [WEAK]
                EXPORT  USB_UCPD1_2_IRQHandler         [WEAK]
                EXPORT  DMA1_Channel1_IRQHandler       [WEAK]
                EXPORT  DMA1_Channel2_3_IRQHandler     [WEAK]
                EXPORT  DMA1_Ch4_7_DMA2_Ch1_5_DMAMUX1_OVR_IRQHandler [WEAK]
                EXPORT  ADC1_COMP_IRQHandler           [WEAK]
                EXPORT  TIM1_BRK_UP_TRG_COM_IRQHandler [WEAK]
                EXPORT  TIM1_CC_IRQHandler             [WEAK]
                EXPORT  TIM2_IRQHandler                [WEAK]
                EXPORT  TIM3_TIM4_IRQHandler           [WEAK]
                EXPORT  TIM6_DAC_LPTIM1_IRQHandler     [WEAK]
                EXPORT  TIM7_LPTIM2_IRQHandler         [WEAK]
                EXPORT  TIM14_IRQHandler               [WEAK]
                EXPORT  TIM15_IRQHandler               [WEAK]
                EXPORT  TIM16_FDCAN_IT0_IRQHandler     [WEAK]
                EXPORT  TIM17_FDCAN_IT1_IRQHandler     [WEAK]
                EXPORT  I2C1_IRQHandler                [WEAK]
                EXPORT  I2C2_3_IRQHandler              [WEAK]
                EXPORT  SPI1_IRQHandler                [WEAK]
                EXPORT  SPI2_3_IRQHandler              [WEAK]
                EXPORT  USART1_IRQHandler              [WEAK]
                EXPORT  USART2_LPUART2_IRQHandler      [WEAK]
                EXPORT  USART3_4_5_6_LPUART1_IRQHandler [WEAK]
                EXPORT  CEC_IRQHandler                 [WEAK]


WWDG_IRQHandler
PVD_VDDIO2_IRQHandler
RTC_TAMP_IRQHandler
FLASH_IRQHandler
RCC_CRS_IRQHandler
EXTI0_1_IRQHandler
EXTI2_3_IRQHandler
EXTI4_15_IRQHandler
USB_UCPD1_2_IRQHandler
DMA1_Channel1_IRQHandler
DMA1_Channel2_3_IRQHandler
DMA1_Ch4_7_DMA2_Ch1_5_DMAMUX1_OVR_IRQHandler
ADC1_COMP_IRQHandler
TIM1_BRK_UP_TRG_COM_IRQHandler
TIM1_CC_IRQHandler
TIM2_IRQHandler
TIM3_TIM4_IRQHandler
TIM6_DAC_LPTIM1_IRQHandler
TIM7_LPTIM2_IRQHandler
TIM14_IRQHandler
TIM15_IRQHandler
TIM16_FDCAN_IT0_IRQHandler
TIM17_FDCAN_IT1_IRQHandler
I2C1_IRQHandler
I2C2_3_IRQHandler
SPI1_IRQHandler
SPI2_3_IRQHandler
USART1_IRQHandler
USART2_LPUART2_IRQHandler
USART3_4_5_6_LPUART1_IRQHandler
CEC_IRQHandler

                B       .

                ENDP

                ALIGN

;*******************************************************************************
; User Stack and Heap initialization
;*******************************************************************************
                 IF      :DEF:__MICROLIB

                 EXPORT  __initial_sp
                 EXPORT  __heap_base
                 EXPORT  __heap_limit

                 ELSE

                 IMPORT  __use_two_region_memory
                 EXPORT  __user_initial_stackheap

__user_initial_stackheap

                 LDR     R0, =  Heap_Mem
                 LDR     R1, =(Stack_Mem + Stack_Size)
                 LDR     R2, = (Heap_Mem +  Heap_Size)
                 LDR     R3, = Stack_Mem
                 BX      LR

                 ALIGN

                 ENDIF

                 END
