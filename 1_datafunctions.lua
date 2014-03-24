function originalToNormalized(s)
   o = s:clone()

   -- class 1 (already normalized)
   local sum = s[2] + s[3] + s[4]
   assert(math.abs(sum - 1.0) <= 1e-4,  'Class1')
   
   -- class 2
   sum = s[5] + s[6]
   if sum ~= 0 then
      o[5] = s[5] / sum
      o[6] = s[6] / sum
   end
   assert(math.abs(sum - s[3]) <= 1e-4,  'Class2')

   -- class 3
   sum = s[7] + s[8]
   if sum ~= 0 then
      o[7] = s[7] / sum
      o[8] = s[8] / sum
   end
   assert(math.abs(sum - s[6]) <= 1e-4,  'Class3,' .. sum .. ',' .. s[6])

   -- class 4
   sum = s[9] + s[10]
   if sum ~= 0 then
      o[9]  = s[9] / sum
      o[10] = s[10] / sum
   end
   assert(math.abs(sum - (s[7] + s[8])) <= 1e-4,  'Class4,' 
	     .. sum .. ',' .. s[7] .. ',' .. s[8])

   -- class 5
   sum = s[11] + s[12] + s[13] + s[14]
   if sum ~= 0 then
      o[11] = s[11] / sum
      o[12] = s[12] / sum
      o[13] = s[13] / sum
      o[14] = s[14] / sum
   end
   assert(math.abs(sum - (s[10] + s[33]+ s[34]+ s[35]
			     + s[36]+ s[37]+ s[38])) <= 1e-4,  'Class5')
   
   -- class 6 (already normalized)
   sum = s[15] + s[16]
   assert(math.abs(sum - 1.0) <= 1e-4,  'Class6')

   -- class 7
   sum = s[17] + s[18] + s[19]
   if sum ~= 0 then
      o[17]  = s[17] / sum
      o[18] = s[18] / sum
      o[19] = s[19] / sum
   end
   assert(math.abs(sum - s[2]) <= 1e-4,  'Class7')

   -- class 8
   sum = s[20] + s[21] + s[22] + s[23] 
      + s[24] + s[25] + s[26]
   if sum ~= 0 then
      o[20]  = s[20] / sum
      o[21]  = s[21] / sum
      o[22]  = s[22] / sum
      o[23]  = s[23] / sum
      o[24]  = s[24] / sum
      o[25]  = s[25] / sum
      o[26]  = s[26] / sum
   end
   assert(math.abs(sum - s[15]) <= 1e-4,  'Class8')

   -- class 9
   sum = s[27] + s[28] + s[29]
   if sum ~= 0 then
      o[27]  = s[27] / sum
      o[28] = s[28] / sum
      o[29] = s[29] / sum
   end
   assert(math.abs(sum - s[5]) <= 1e-4,  'Class9')

   -- class 10
   sum = s[30] + s[31] + s[32]
   if sum ~= 0 then
      o[30]  = s[30] / sum
      o[31] = s[31] / sum
      o[32] = s[32] / sum
   end
   assert(math.abs(sum - s[9]) <= 1e-4,  'Class10')

   -- class 11
   sum = s[33] + s[34] + s[35] 
      + s[36] + s[37] + s[38]
   if sum ~= 0 then
      o[33]  = s[33] / sum
      o[34] = s[34] / sum
      o[35] = s[35] / sum
      o[36] = s[36] / sum
      o[37] = s[37] / sum
      o[38] = s[38] / sum
   end
   assert(math.abs(sum - (s[30]+s[31]+s[32])) <= 1e-4,  'Class11')
   return o;
end

function normalizedToOriginal(s)
   local prune = false
   if s:size(1) == 37 then
      local t = torch.zeros(38)
      t[{{2,38}}] = s
      s = t
      prune = true
   end
   -- sample is a tensor of size 38.
   local o = s:clone()
   -- class 2
   o[5] = o[5] * s[3]
   o[6] = o[6] * s[3]
   -- class 3
   o[7] = o[7] * o[6]
   o[8] = o[8] * o[6]
   -- class 4
   o[9] = o[9] * (o[7] + o[8])
   o[10] = o[10] * (o[7] + o[8])
   -- class 10
   o[30] = o[30] * o[9]
   o[31] = o[31] * o[9]
   o[32] = o[32] * o[9]
   -- class 11
   o[33] = o[33] * (o[30]+o[31]+o[32])
   o[34] = o[34] * (o[30]+o[31]+o[32])
   o[35] = o[35] * (o[30]+o[31]+o[32])
   o[36] = o[36] * (o[30]+o[31]+o[32])
   o[37] = o[37] * (o[30]+o[31]+o[32])
   o[38] = o[38] * (o[30]+o[31]+o[32])
   -- class 5
   o[11] = o[11] * (o[10] + o[33] + o[34] + o[35] + o[36] + o[37] + o[38])
   o[12] = o[12] * (o[10] + o[33] + o[34] + o[35] + o[36] + o[37] + o[38])
   o[13] = o[13] * (o[10] + o[33] + o[34] + o[35] + o[36] + o[37] + o[38])
   o[14] = o[14] * (o[10] + o[33] + o[34] + o[35] + o[36] + o[37] + o[38])
   -- class 6 (already normalized)
   -- class 7
   o[17] = o[17] * o[2]
   o[18] = o[18] * o[2]
   o[19] = o[19] * o[2]
   -- class 8
   o[20] = o[20] * o[15]
   o[21] = o[21] * o[15]
   o[22] = o[22] * o[15]
   o[23] = o[23] * o[15]
   o[24] = o[24] * o[15]
   o[25] = o[25] * o[15]
   o[26] = o[26] * o[15]
   -- class 9
   o[27] = o[27] * o[5]
   o[28] = o[28] * o[5]
   o[29] = o[29] * o[5]
   if prune then
      o = o[{{2,38}}]
   end
   return o
end

function jitter(s)
   local d = torch.rand(7)
   -- vflip
   if d[1] > 0.5 then
      s:flip()
   end
   -- hflip
   if d[2] > 0.5 then
      s:flop()
   end
   -- rotation
   if d[3] > 0.5 then
      s:rotate(360 * d[4])
   end
   -- crop a 223x223 random patch
   local startX = math.ceil(d[6] * (loadSize[2] - sampleSize[2] - 1))
   local startY = math.ceil(d[7] * (loadSize[3] - sampleSize[3] - 1))
   local endX = startX + sampleSize[2]
   local endY = startY + sampleSize[3]
   s:crop(sampleSize[2], sampleSize[3], startX, startY)
   return s
end