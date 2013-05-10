# RUN: llvm-mc -triple s390x-linux-gnu -show-encoding %s | FileCheck %s

#CHECK: ste	%f0, 0                  # encoding: [0x70,0x00,0x00,0x00]
#CHECK: ste	%f0, 4095               # encoding: [0x70,0x00,0x0f,0xff]
#CHECK: ste	%f0, 0(%r1)             # encoding: [0x70,0x00,0x10,0x00]
#CHECK: ste	%f0, 0(%r15)            # encoding: [0x70,0x00,0xf0,0x00]
#CHECK: ste	%f0, 4095(%r1,%r15)     # encoding: [0x70,0x01,0xff,0xff]
#CHECK: ste	%f0, 4095(%r15,%r1)     # encoding: [0x70,0x0f,0x1f,0xff]
#CHECK: ste	%f15, 0                 # encoding: [0x70,0xf0,0x00,0x00]

	ste	%f0, 0
	ste	%f0, 4095
	ste	%f0, 0(%r1)
	ste	%f0, 0(%r15)
	ste	%f0, 4095(%r1,%r15)
	ste	%f0, 4095(%r15,%r1)
	ste	%f15, 0
