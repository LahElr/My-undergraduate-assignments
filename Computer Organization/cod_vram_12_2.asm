j start
nop
nop
nop
nop
nop
nop
nop
nop
j RI
nop
j overflow
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
start:
addi $sp,$0,0x3fe0

lui $t0,0xffff
ori $t0,$t0,0x8001
sw $t0,0($sp)
lui $t0,0xffed
ori $t0,$t0,0x8009
sw $t0,4($sp)
lui $t0,0xbffb
ori $t0,$t0,0xa021
sw $t0,8($sp)
lui $t0,0xaf8f
ori $t0,$t0,0xa0e1
sw $t0,12($sp)
lui $t0,0xbe39
ori $t0,$t0,0x88af
sw $t0,16($sp)
lui $t0,0xa281
ori $t0,$t0,0xffff
sw $t0,20($sp)

lui $a1,0x0770
jal clear

add $t0,$0,$sp#t0:base_addr
add $s0,$0,$0#x=0
add $s1,$0,$0#y=0

lw $t1,0($t0)#取两行
draw_map_line_cycle:
lui $t2,0x8000
and $t2,$t2,$t1#取最高位
srl $t2,$t2,31
beq $t2,$0,draw_map_line_cycle_fin#是0000_0000就不画这格，是8000_0000就画
#jal put_block
ori $a1,$0,0x0028
add $a0,$0,$s0
jal multiu_16#x*40
add $t6,$0,$v0#t6:x*40
add $a0,$0,$s1
jal multiu_16#y*40
add $t5,$0,$v0#t5:y*40

lui $a1,0x09c3
sll $a0,$t6,16
or $a0,$a0,$t5
addi $t5,$t5,0x27
addi $t6,$t6,0x27
sll $a2,$t6,16
or $a2,$a2,$t5
jal put_solid_rect
#jal put_block
draw_map_line_cycle_fin:
sll $t1,$t1,1#左推一位
addi $s0,$s0,0x1#x+=1
slti $t7,$s0,16#x<16?
bne $t7,$0,draw_map_line_cycle#if x >= 16 then go down
add $s0,$0,$0#x=0
addi $s1,$s1,1#y+=1
bne $t1,$0,draw_map_line_cycle#如果这两行还没有被推到0，也就是说t1里还剩着前16位是另一行，就刷新x和y借着画

addi $t0,$t0,4
lw $t1,0($t0)#取下两行
#add $s0,$0,$0#x=0
#addi $s1,$s1,1#y+=1
slti $t7,$s1,12#y<12?
bne $t7,$0,draw_map_line_cycle#if y >= 12 then break

lui $a0,0x0235
ori $a0,$a0,0x0195
lui $a1,0xfff
lui $a2,0x0253
ori $a2,$a2,0x01b3
jal put_solid_rect

addi $s7,$0,0x1#s7:x
addi $s6,$0,0x1#s6:y
lui $s5,0x7f4c
ori $s5,$s5,0xd2e6#s5:seed
#每次都会将s5的低5位(……_?????)取出来作为半径
#s5的最大值是0b10011，所以必须对高位做判断，若是1，则2、3位置0
#然后s5将被左推1位，并与旧s5 xor后取反(最后一位每次都会被置反)
#这件事每轮循环都做，但是一轮循环很快所以谁也不知道下一次半径会是多少
ori $s4,$0,0x0013#s4:r初值
add $s3,$0,$s4#s3:旧的r
add $a3,$0,$s4
lui $a1,0x0fd0
jal put_character

loop:

andi $s4,$s5,0x001f#s4:r
srl $t0,$s4,4#取最高位
beq $t0,$0,get_r_omit_correction
andi $s4,$s4,0xfff3#2、3位置0
get_r_omit_correction:
sll $t0,$s5,1
xor $s5,$s5,$t0#xor
lui $k1,0xffff
ori $k1,$k1,0xffff
xor $s5,$s5,$k1#取反————更新seed

lui $t4,0xc000
lw $t4,0($t4)#得到按键码
srl $t3,$t4,31#查看KRDY
sll $k0,$k0,1#past_key_ready << 1
andi $k0,$k0,0x0002
add $k0,$k0,$t3#{30'b0,past_key_ready,now_key_ready}

lui $gp,0xe000
sw $k0,0($gp)

addi $k0,$k0,-2# if(past_key_ready == 1 && now key_ready == 0) past_key_ready = 0
beq $k0,$0,loop_omit# if k0 == 0
#也就是不是key_ready下降沿的话，就回去loop
#beq $t3,$0,loop#如果KRDY是0，那么就重新开始循环
# if(past_key_ready == 1 && now key_ready == 0) do
# else go back to loop
add $k0,$0,$t3#past_key_ready = now_key_ready
j loop
loop_omit:
add $k0,$0,$0



andi $t4,$t4,0x001f#取低5位
addi $t3,$t4,-4
beq $t3,$0,move_4
addi $t3,$t4,-6
beq $t3,$0,move_6
addi $t3,$t4,-9
beq $t3,$0,move_9
addi $t3,$t4,-1
beq $t3,$0,move_1
j loop#如果都不是，就重新开始循环

move_4:#左
lui $t8,0x4444
addi $t2,$s7,-1#t2=x-1
sll $a1,$t2,4
or $a1,$a1,$s6
add $t9,$0,$a1
jal is_wall
add $t8,$0,$v0
bne $v0,$0,loop#如果是墙，就重新开始循环
lui $a1,0x0770
add $a3,$0,$s3
jal put_character#覆盖旧的
add $s3,$0,$s4#s3:刷新旧r
addi $s7,$s7,-1#x-=1
lui $a1,0x0fd0
add $a3,$0,$s4
jal put_character
j move_fin

move_6:#右
lui $t8,0x4444
addi $t2,$s7,1#t2=x+1
sll $a1,$t2,4
or $a1,$a1,$s6
add $t9,$0,$a1
jal is_wall
add $t8,$0,$v0
bne $v0,$0,loop#如果是墙，就重新开始循环
lui $a1,0x0770
add $a3,$0,$s3
jal put_character#覆盖旧的
add $s3,$0,$s4#s3:刷新旧r
addi $s7,$s7,1#x+=1
lui $a1,0x0fd0
add $a3,$0,$s4
jal put_character
j move_fin

move_9:#下
lui $t8,0x4444
addi $t2,$s6,1#t2=y+1
sll $a1,$s7,4
or $a1,$a1,$t2
add $t9,$0,$a1
jal is_wall
add $t8,$0,$v0
bne $v0,$0,loop#如果是墙，就重新开始循环
lui $a1,0x0770
add $a3,$0,$s3
jal put_character#覆盖旧的
add $s3,$0,$s4#s3:刷新旧r
addi $s6,$s6,1#y+=1
lui $a1,0x0fd0
add $a3,$0,$s4
jal put_character
j move_fin

move_1:#上
lui $t8,0x4444
addi $t2,$s6,-1#t2=y-1
sll $a1,$s7,4
or $a1,$a1,$t2
add $t9,$0,$a1
jal is_wall
add $t8,$0,$v0
bne $v0,$0,loop#如果是墙，就重新开始循环
lui $a1,0x0770
add $a3,$0,$s3
jal put_character#覆盖旧的
add $s3,$0,$s4#s3:刷新旧r
addi $s6,$s6,-1#y-=1
lui $a1,0x0fd0
add $a3,$0,$s4
jal put_character
j move_fin

move_fin:
sll $t0,$s7,4
or $t0,$t0,$s6
ori $t1,$0,0x00ea
sub $t0,$t0,$t1
bne $t0,$0,loop
lui $a1,0x0770
jal clear

#j loop

nop

put_character:#s5:seed,s7:x,s6:y,a1:color,a3:r#之所以敢不使用a系列是因为这一段铁定不可能在别的情况下被调用
addi $sp,$sp,-16
sw $t7,0($sp)
sw $t6,4($sp)
sw $t5,8($sp)
sw $ra,12($sp)
#put_ring:#a0:0xxx_0yyy:center, a1:0rgb_000:color, a2:RRRR_rrrr:exradius and inradius
add $t5,$0,$a1#t5:color
ori $a0,$0,0x28
add $a1,$0,$s7
jal multiu_16#x*40
add $t7,$0,$v0#t7:x*40
add $a1,$0,$s6
jal multiu_16#y*40
add $t6,$0,$v0#t6:y*40
addi $t7,$t7,0x14#t7:x*40+20
addi $t6,$t6,0x14#t6:y*40+20

sll $a2,$a3,16
sll $a0,$t7,16
or $a0,$a0,$t6
add $a1,$0,$t5
jal put_ring#put it

lw $t7,0($sp)
lw $t6,4($sp)
lw $t5,8($sp)
lw $ra,12($sp)
addi $sp,$sp,16
jr $ra

nop

is_wall:#a1:0000_00xy
addi $sp,$sp,-12
sw $t1,0($sp)
sw $t2,4($sp)
sw $t3,8($sp)

addi $t1,$0,0x3fe0
andi $t2,$a1,0x000f#t2=0000_000y
andi $t3,$t2,0x0001#t3->y%2#在前一半(0)还是后一半(1)
srl $t2,$t2,1#t2/=2-->y/=2#y=0:取0，y=1:取0
sll $t2,$t2,2#再乘4变成4的倍数然后可以作为地址加算进去
add $t1,$t1,$t2#base+=4*(y//2)
lw $t1,0($t1)#t1:????_???? 某一半是当前行
beq $0,$t3,is_wall_former_half
#t1:xxxx_????后一半是当前行
andi $t1,$t1,0xffff#拿出当前行 t1:0000_????
j is_wall_half_got
is_wall_former_half:
#t1:????_xxxx前一半是当前行
srl $t1,$t1,16#推到当前行 t1:0000_????
is_wall_half_got:
andi $t2,$a1,0x00f0#t2:0000_00x0
srl $t2,$t2,4#t2:0000_000x
sllv $t1,$t1,$t2#e.g. 8009,x=1:推完变成1_0012
andi $t1,$t1,0x8000#取低16位最高，即要取的位
srl $t1,$t1,15#推到最低位
add $v0,$0,$t1#movl $t1->$v0

lw $t1,0($sp)
lw $t2,4($sp)
lw $t3,12($sp)
addi $sp,$sp,12
jr $ra

nop

put_solid_rect:#a0:0xxx_0yyy:start, a1:0rgb_000:color, a2:0xxx_0yyy:end
addi $sp,$sp,-32
sw $a1,28($sp)
sw $ra,24($sp)
sw $t2,20($sp)#temp
sw $t3,16($sp)#maxx
sw $t4,12($sp)#maxy-->deltay
sw $t5,8($sp)#minx-->x
sw $t6,4($sp)#miny
sw $t7,0($sp)#cmp

# get parameters
lui $t5,0x0fff
and $t5,$t5,$a0
srl $t5,$t5,16 # start_x
andi $t6,$a0,0x0fff # start_y
lui $t3,0x0fff
and $t3,$t3,$a2
srl $t3,$t3,16 # end_x
andi $t4,$a2,0x0fff # end_y

slti $t7,$t5,0x280#x<640?
beq $t7,$0,put_solid_rect_fin#if not so,fin
slti $t7,$t6,0x1e0#y<480?
beq $t7,$0,put_solid_rect_fin#if not so,fin
slti $t7,$t3,0x280#x<640?
beq $t7,$0,put_solid_rect_fin#if not so,fin
slti $t7,$t4,0x1e0#y<480?
beq $t7,$0,put_solid_rect_fin#if not so,fin

#compare
slt $t7,$t5,$t3 # cmp = start_x < end_x ?
bne $t7,$0,put_solid_rect_not_switch_x # if start_x >= end_x
add $t2,$0,$t5 # temp = start_x
add $t5,$0,$t3 # start_x = end_x
add $t3,$0,$t2 # end_x = temp
put_solid_rect_not_switch_x:
# $t5:minx, $t3:maxx
slt $t7,$t6,$t4 # cmp = start_y < end_y ?
bne $t7,$0,put_solid_rect_not_switch_y # if start_y >= end_y
add $t2,$0,$t6 # temp = start_y
add $t6,$0,$t4 # start_y = end_y
add $t4,$0,$t2 # end_y = temp
put_solid_rect_not_switch_y:
# $t6:miny, $t4:maxy
sub $t4,$t4,$t6 # t4:deltay

# put_line_y_posi:# a0:start:0xxx_0yyy,a1:0rgb_0000,a2:length
#t5:x
put_solid_rect_cycle:
sll $a0,$t5,16
or $a0,$a0,$t6
add $a2,$0,$t4
jal put_line_y_posi
addi $t5,$t5,0x0001 # x += 1
slt $t7,$t3,$t5 # maxx < x?
beq $t7,$0,put_solid_rect_cycle # if not so (maxx >= x): go back the start of the cycle

put_solid_rect_fin:
lw $a1,28($sp)
lw $ra,24($sp)
lw $t2,20($sp)
lw $t3,16($sp)
lw $t4,12($sp)
lw $t5,8($sp)
lw $t6,4($sp)
lw $t7,0($sp)
addi $sp,$sp,32
jr $ra

nop

put_ring:#a0:0xxx_0yyy:center, a1:0rgb_000:color, a2:RRRR_rrrr:exradius and inradius
addi $sp,$sp,-56
sw $a1,52($sp)
sw $ra,48($sp)
sw $t4,44($sp)#R^2
sw $t5,40($sp)#r^2
sw $t6,36($sp)#miny
sw $t7,32($sp)#cmp
sw $s7,28($sp)#R, or R+centerx
sw $s6,24($sp)#r, or R+centery
sw $s5,20($sp)#(centery-y)^2
sw $s4,16($sp)#(centerx-x)^2
sw $s0,12($sp)#centerx
sw $s1,8($sp)#centery
sw $s2,4($sp)#x
sw $s3,0($sp)#y

#get parameters and check
lui $s0,0x0fff
and $s0,$a0,$s0 #centerx,positive assured
srl $s0,$s0,16
andi $s1,$a0,0x0fff #centery,positive assured
slti $t7,$s0,0x280#x<640?
beq $t7,$0,put_ring_fin#if not so,fin
slti $t7,$s1,0x1e0#y<480?
beq $t7,$0,put_ring_fin#if not so,fin

lui $s7,0xffff
and $s7,$a2,$s7 #R,positive assured
srl $s7,$s7,16
andi $s6,$a2,0xffff #r,positive assured

sub $s2,$s0,$s7#x = centerx - R
slt $t7,$s2,$0#if x < 0
beq $t7,$0,put_ring_x_start_more_than_0
add $s2,$0,$0#x = 0
put_ring_x_start_more_than_0:
sub $s3,$s1,$s7#y = centery - R
slt $t7,$s3,$0#if y < 0
beq $t7,$0,put_ring_y_start_more_than_0
add $s3,$0,$0#y = 0
put_ring_y_start_more_than_0:

add $a0,$0,$s7
add $a1,$0,$s7
jal multiu_16#R^2 = R * R
add $t4,$0,$v0

add $a0,$0,$s6
add $a1,$0,$s6
jal multiu_16#r^2 = r * r
add $t5,$0,$v0

add $s6,$s7,$s1#centery+R
add $s7,$s7,$s0#centerx+R

slti $t7,$s7,0x280#centerx+R<640?
bne $t7,$0,put_ring_centerxR_less_than_640#if so
addi $s7,$0,0x27f#if not, centerx+R=639
put_ring_centerxR_less_than_640:

slti $t7,$s6,0x1e0#centery+R<480?
bne $t7,$0,put_ring_centeryR_less_than_480#if so
addi $s6,$0,0x1df#if not, centery+R=479
put_ring_centeryR_less_than_480:

add $t6,$0,$3#miny = y

put_ring_cycle_x:
nop
put_ring_cycle_y:
#$s5 = abs(centery - y)
#$s4 = abs(centerx - x)
slt $t7,$s1,$s3#centery<y?
beq $t7,$0,put_ring_cycle_y_centery_more_than_y#if centery >= y
sub $s5,$s3,$s1#s5 = y - centery
j put_ring_cycle_y_centery_more_than_y_fin
put_ring_cycle_y_centery_more_than_y:
sub $s5,$s1,$s3#s5 = centery - y
put_ring_cycle_y_centery_more_than_y_fin:

slt $t7,$s0,$s2#centerx<x?
beq $t7,$0,put_ring_cycle_y_centery_more_than_x#if centerx >= x
sub $s4,$s2,$s0#s4 = x - centerx
j put_ring_cycle_y_centery_more_than_x_fin
put_ring_cycle_y_centery_more_than_x:
sub $s4,$s0,$s2#s5 = centerx - x
put_ring_cycle_y_centery_more_than_x_fin:

add $a0,$0,$s5
add $a1,$0,$s5
jal multiu_16#s5 = (centery-y)^2
add $s5,$0,$v0

add $a0,$0,$s4
add $a1,$0,$s4
jal multiu_16#s4 = (centerx-x)^2
add $s4,$0,$v0

add $s5,$s5,$s4#s5 = (delx^2+dely^2)
slt $t7,$t4,$s5#s5 > R^2?
bne $t7,$0,put_ring_cycle_y_not#s5 > R^2,do not draw it
slt $t7,$s5,$t5#s5 < r^2?
bne $t7,$0,put_ring_cycle_y_not#s5 < r^2 ,do not draw it

#draw it!
sll $a0,$s2,16
or $a0,$a0,$s3
lw $a1,52($sp)
jal put_point

put_ring_cycle_y_not:

addi $s3,$s3,1#y += 1
slt $t7,$s6,$s3#centeryR < y?
bne $t7,$0,put_ring_cycle_y_fin#if so, fin
j put_ring_cycle_y

put_ring_cycle_y_fin:

add $s3,$0,$t6#y = miny
addi $s2,$s2,1#x += 1
slt $t7,$s7,$s2#centerxR < x?
bne $t7,$0,put_ring_fin#if so,fin

j put_ring_cycle_x

put_ring_fin:
lw $a1,52($sp)
lw $ra,48($sp)
lw $t4,44($sp)#R^2
lw $t5,40($sp)#r^2
lw $t6,36($sp)#miny
lw $t7,32($sp)#cmp
lw $s7,28($sp)#R, or R+centerx
lw $s6,24($sp)#r, or R+centery
lw $s5,20($sp)#(centery-y)^2
lw $s4,16($sp)#(centerx-x)^2
lw $s0,12($sp)#centerx
lw $s1,8($sp)#centery
lw $s2,4($sp)#x
lw $s3,0($sp)#y
addi $sp,$sp,56
jr $ra

nop

put_line_x_posi:#a0:start:0xxx_0yyy,a1:0rgb_0000,a2:length
#stack:
addi $sp,$sp,-20
sw $t4,16($sp)#temp
sw $s3,12($sp)#length
sw $s2,8($sp)#color
sw $s1,4($sp)#y
sw $s0,0($sp)#x
#process:
#get parameter and check:
lui $s0,0x0fff
and $s0,$a0,$s0 #x,positive assured
srl $s0,$s0,16
andi $s1,$a0,0x0fff #y,positive assured
slti $t4,$s0,0x280#x<640?
beq $t4,$0,put_line_x_posi_fin#if not so,fin
slti $t4,$s1,0x1e0#y<480?
beq $t4,$0,put_line_x_posi_fin#if not so,fin
add $s2,$a1,$0#load color
add $s3,$a2,$0#load length
#cycle
addi $sp,$sp,-4
sw $ra,0($sp)
put_line_x_posi_cycle:
sll $a0,$s0,16
or $a0,$a0,$s1#load parameter
jal put_point
addi $s3,$s3,-1#length-=1
addi $s0,$s0,1#x+=1
slt $t4,$s3,$0#if length < 0,fin
bne $t4,$0,put_line_x_posi_fin
j put_line_x_posi_cycle
put_line_x_posi_fin:
lw $ra,0($sp)
addi $sp,$sp,4
#stack:
lw $t4,16($sp)#temp
lw $s3,12($sp)#length
lw $s2,8($sp)#color
lw $s1,4($sp)#y
lw $s0,0($sp)#x
addi $sp,$sp,20
jr $ra

nop

put_line_x_nega:#a0:start:0xxx_0yyy,a1:0rgb_0000,a2:length
#stack:
addi $sp,$sp,-20
sw $t4,16($sp)#temp
sw $s3,12($sp)#length
sw $s2,8($sp)#color
sw $s1,4($sp)#y
sw $s0,0($sp)#x
#process:
#get parameter and check:
lui $s0,0x0fff
and $s0,$a0,$s0 #x,positive assured
srl $s0,$s0,16
andi $s1,$a0,0x0fff #y,positive assured
slti $t4,$s0,0x280#x<640?
beq $t4,$0,put_line_x_nega_fin#if not so,fin
slti $t4,$s1,0x1e0#y<480?
beq $t4,$0,put_line_x_nega_fin#if not so,fin
add $s2,$a1,$0#load color
add $s3,$a2,$0#load length
#cycle
addi $sp,$sp,-4
sw $ra,0($sp)
put_line_x_nega_cycle:
sll $a0,$s0,16
or $a0,$a0,$s1#load parameter
jal put_point
addi $s3,$s3,-1#length-=1
addi $s0,$s0,-1#x-=1
slt $t4,$s3,$0#if length < 0,fin
bne $t4,$0,put_line_x_nega_fin
j put_line_x_nega_cycle
put_line_x_nega_fin:
lw $ra,0($sp)
addi $sp,$sp,4
#stack:
lw $t4,16($sp)#temp
lw $s3,12($sp)#length
lw $s2,8($sp)#color
lw $s1,4($sp)#y
lw $s0,0($sp)#x
addi $sp,$sp,20
jr $ra

nop

put_line_y_posi:#a0:start:0xxx_0yyy,a1:0rgb_0000,a2:length
#stack:
addi $sp,$sp,-20
sw $t4,16($sp)#temp
sw $s3,12($sp)#length
sw $s2,8($sp)#color
sw $s1,4($sp)#y
sw $s0,0($sp)#x
#process:
#get parameter and check:
lui $s0,0x0fff
and $s0,$a0,$s0 #x,positive assured
srl $s0,$s0,16
andi $s1,$a0,0x0fff #y,positive assured
slti $t4,$s0,0x280#x<640?
beq $t4,$0,put_line_y_posi_fin#if not so,fin
slti $t4,$s1,0x1e0#y<480?
beq $t4,$0,put_line_y_posi_fin#if not so,fin
add $s2,$a1,$0#load color
add $s3,$a2,$0#load length
#cycle
addi $sp,$sp,-4
sw $ra,0($sp)
put_line_y_posi_cycle:
sll $a0,$s0,16
or $a0,$a0,$s1#load parameter
jal put_point
addi $s3,$s3,-1#length-=1
addi $s1,$s1,1#y+=1
slt $t4,$s3,$0#if length < 0,fin
bne $t4,$0,put_line_y_posi_fin
j put_line_y_posi_cycle
put_line_y_posi_fin:
lw $ra,0($sp)
addi $sp,$sp,4
#stack:
lw $t4,16($sp)#temp
lw $s3,12($sp)#length
lw $s2,8($sp)#color
lw $s1,4($sp)#y
lw $s0,0($sp)#x
addi $sp,$sp,20
jr $ra

nop

put_line_y_nega:#a0:start:0xxx_0yyy,a1:0rgb_0000,a2:length
#stack:
addi $sp,$sp,-20
sw $t4,16($sp)#temp
sw $s3,12($sp)#length
sw $s2,8($sp)#color
sw $s1,4($sp)#y
sw $s0,0($sp)#x
#process:
#get parameter and check:
lui $s0,0x0fff
and $s0,$a0,$s0 #x,positive assured
srl $s0,$s0,16
andi $s1,$a0,0x0fff #y,positive assured
slti $t4,$s0,0x280#x<640?
beq $t4,$0,put_line_y_nega_fin#if not so,fin
slti $t4,$s1,0x1e0#y<480?
beq $t4,$0,put_line_y_nega_fin#if not so,fin
add $s2,$a1,$0#load color
add $s3,$a2,$0#load length
#cycle
addi $sp,$sp,-4
sw $ra,0($sp)
put_line_y_nega_cycle:
sll $a0,$s0,16
or $a0,$a0,$s1#load parameter
jal put_point
addi $s3,$s3,-1#length-=1
addi $s1,$s1,-1#y-=1
slt $t4,$s3,$0#if length < 0,fin
bne $t4,$0,put_line_x_nega_fin
j put_line_y_nega_cycle
put_line_y_nega_fin:
lw $ra,0($sp)
addi $sp,$sp,4
#stack:
lw $t4,16($sp)#temp
lw $s3,12($sp)#length
lw $s2,8($sp)#color
lw $s1,4($sp)#y
lw $s0,0($sp)#x
addi $sp,$sp,20
jr $ra

nop

put_point:#a0:0xxx_0yyy,a1:0rgb_0000
#stack:
addi $sp,$sp,-20
sw $t4,16($sp)#temp
sw $t3,12($sp)#color_of_the_pixel_afterwards
sw $t2,8($sp)#address
sw $t1,4($sp)#y
sw $t0,0($sp)#x
#process:
#get parameter and check:
lui $t0,0x0fff
and $t0,$a0,$t0 #x,positive assured
srl $t0,$t0,16
andi $t1,$a0,0x0fff #y,positive assured
slti $t2,$t0,0x280#x<640?
beq $t2,$0,put_point_fin#if not so,fin
slti $t2,$t1,0x1e0#y<480?
beq $t2,$0,put_point_fin#if not so,fin
#set start address of vram_graph
lui $t2,0x000c
ori $t2,$t2,0x2000
#t2+=(t0+t1*640)*2
addi $sp,$sp,-12
sw $ra,8($sp)
sw $a0,4($sp)
sw $a1,0($sp)
add $a0,$t1,$0
addi $a1,$0,640
jal multiu_16#t1*640
lw $a1,0($sp)
lw $a0,4($sp)
lw $ra,8($sp)
addi $sp,$sp,12
add $v0,$v0,$t0#t0+
sll $v0,$v0,1#*2
add $t2,$t2,$v0#t2+=
#lw $t3,0($t2)
#andi $t3,$t3,0xffff#取低位
#lui $t4,0xffff
#and $a1,$t4,$a1#清空低位
#or $a1,$a1,$t3#合成
#write to vram
sw $a1,0($t2)
#stack
put_point_fin:
lw $t0,0($sp)
lw $t1,4($sp)
lw $t2,8($sp)
lw $t3,12($sp)
lw $t4,16($sp)#temp
addi $sp,$sp,20
jr $ra

nop

clear:#a1:0rgb_0000
#stack
addi $sp,$sp,-12
sw $t2,8($sp)#end
sw $t1,4($sp)#temp
sw $t0,0($sp)#now

srl $t1,$a1,16
or $a1,$a1,$t1#a1:0rgb_0rgb
#load the address
lui $t0,0x000c
ori $t0,$t0,0x2000
lui $t2,0x0015
ori $t2,$t2,0x8000
clear_loop:
sw $a1,0($t0)
addi $t0,$t0,2
slt $t1,$t0,$t2#if now >= end ,fin
beq $t1,$0,clear_fin
j clear_loop
clear_fin:
andi $a1,$a1,0xffff
sll $a1,$a1,16
#stack
lw $t2,8($sp)
lw $t1,4($sp)
lw $t0,0($sp)
addi $sp,$sp,12
jr $ra

nop

multiu_16:#(unsigned b16) a0 * (unsigned b16) a1
addi $sp,$sp,-20
sw $t0,0($sp)
sw $t1,4($sp)#count
sw $t2,8($sp)#temp
sw $a1,12($sp)
sw $a0,16($sp)
andi $a1,$a1,0xffff
andi $a0,$a0,0xffff
addi $t1,$0,0x00010#count = 16
add $v0,$0,$0#product = 0
multiu_16_cycle:
andi $t2,$a0,0x0001#temp = a0/2
beq $t2,$0,multiu_16_cycle_omit#if a2/2==1:
add $v0,$v0,$a1#product+=a1
multiu_16_cycle_omit:
sll $a1,$a1,1#a1*=2
srl $a0,$a0,1#a2/=2
addi $t1,$t1,-1#count-=1
slt $t2,$0,$t1#temp = (count>0)?
bne $t2,$0,multiu_16_cycle#if count>0, cycle
multiu_16_fin:
lw $t0,0($sp)
lw $t1,4($sp)#count
lw $t2,8($sp)#temp
lw $a1,12($sp)
lw $a0,16($sp)
addi $sp,$sp,20
jr $ra

nop

divideu:# a0/a1=v0...v1
addi $sp,$sp,-8
sw $t1,4($sp)
sw $t0,0($sp)#temp
add $t1,$0,$0
add $v0,$0,$0
add $v1,$0,$0
slt $t0,$0,$a1#if 0 >= a1 , fin
beq $t0,$0,divideu_fin
slt $t0,$0,$a0#if 0 >= a0 , fin
beq $t0,$0,divideu_fin
divideu_cycle:
slt $t0,$a0,$a1#if a0 < a1 , fin
bne $t0,$0,divideu_fin
addi $v0,$v0,1#count++
sub $a0,$a0,$a1#a0-=a1
j divideu_cycle
divideu_fin:
add $a0,$0,$v1
#stack
lw $t1,4($sp)
lw $t0,0($sp)
addi $sp,$sp,8
jr $ra

nop

sleep:#sleep a0
addi $sp,$sp,-4
sw $t0,0($sp)
sleep_cycle:
addi $a0,$a0,-1
slt $t0,$a0,$0
bne $t0,$0,sleep_fin
j sleep_cycle
sleep_fin:
lw $t0,0($sp)
addi $sp,$sp,4
jr $ra

nop

stop:#an endless loop:a manual breakpoint
j stop

overflow:
eret

RI:
eret

j stop