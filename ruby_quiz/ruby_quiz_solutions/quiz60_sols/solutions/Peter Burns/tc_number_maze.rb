def solve(start, finish)
  [start]
end






def valid?(params,result)
  return false if result.first != params[0]
  return false if result.last != params[1]

  prev = result.first
  result.each do |value|
    return false if value != value.to_i
    if value == prev or value == prev/2 or value == prev*2 or value == prev+2
       prev = value
       next
    end
    return false
  end
  true
end


#metaprogramming help, courtesy of _why the lucky stiff
class Object
  # The hidden singleton lurks behind everyone
  def metaclass; class << self; self; end; end
  def meta_eval &blk; metaclass.instance_eval &blk; end

  # Adds methods to a metaclass
  def meta_def name, &blk
    meta_eval { define_method name, &blk }
  end

   # Defines an instance method within a class
  def class_def name, &blk
    class_eval { define_method name, &blk }
  end
end



require 'test/unit'

class TestNumericMaze < Test::Unit::TestCase
  test_cases = [
  [[1, 1], [1]], #=> test_case_0
  [[2, 2], [2]], #=> test_case_1
  [[3, 3], [3]], #=> test_case_2
  [[4, 4], [4]], #=> test_case_3
  [[5, 5], [5]], #=> test_case_4
  [[6, 6], [6]], #=> test_case_5
  [[7, 7], [7]], #=> test_case_6
  [[8, 8], [8]], #=> test_case_7
  [[9, 9], [9]], #=> test_case_8
  [[0, 1], [0,2,1]], #=> test_case_9
  [[0, 2], [0,2]], #=> test_case_10
  [[0, 3], [0,2,1,3]], #=> test_case_11
  [[0, 4], [0,2,4]], #=> test_case_12
  [[0, 5], [0,2,1,3,5]], #=> test_case_13
  [[0, 6], [0,2,4,6]], #=> test_case_14
  [[0, 7], [0,2,1,3,5,7]], #=> test_case_15
  [[0, 8], [0,2,4,8]], #=> test_case_16
  [[0, 9], [0,2,1,3,5,7,9]], #=> test_case_17
  [[1, 2], [1,2]], #=> test_case_18
  [[1, 3], [1,3]], #=> test_case_19
  [[1, 4], [1,2,4]], #=> test_case_20
  [[1, 5], [1,3,5]], #=> test_case_21
  [[1, 6], [1,3,6]], #=> test_case_22
  [[1, 7], [1,3,5,7]], #=> test_case_23
  [[1, 8], [1,2,4,8]], #=> test_case_24
  [[1, 9], [1,3,5,7,9]], #=> test_case_25
  [[2, 1], [2,1]], #=> test_case_26
  [[2, 3], [2,1,3]], #=> test_case_27
  [[2, 4], [2,4]], #=> test_case_28
  [[2, 5], [2,1,3,5]], #=> test_case_29
  [[2, 6], [2,4,6]], #=> test_case_30
  [[2, 7], [2,1,3,5,7]], #=> test_case_31
  [[2, 8], [2,4,8]], #=> test_case_32
  [[2, 9], [2,1,3,5,7,9]], #=> test_case_33
  [[3, 1], [3,6,8,4,2,1]], #=> test_case_34
  [[3, 2], [3,6,8,4,2]], #=> test_case_35
  [[3, 4], [3,6,8,4]], #=> test_case_36
  [[3, 5], [3,5]], #=> test_case_37
  [[3, 6], [3,6]], #=> test_case_38
  [[3, 7], [3,5,7]], #=> test_case_39
  [[3, 8], [3,6,8]], #=> test_case_40
  [[3, 9], [3,5,7,9]], #=> test_case_41
  [[4, 1], [4,2,1]], #=> test_case_42
  [[4, 2], [4,2]], #=> test_case_43
  [[4, 3], [4,6,3]], #=> test_case_44
  [[4, 5], [4,6,3,5]], #=> test_case_45
  [[4, 6], [4,6]], #=> test_case_46
  [[4, 7], [4,6,12,14,7]], #=> test_case_47
  [[4, 8], [4,8]], #=> test_case_48
  [[4, 9], [4,8,16,18,9]], #=> test_case_49
  [[5, 1], [5,10,12,6,8,4,2,1]], #=> test_case_50
  [[5, 2], [5,10,12,6,8,4,2]], #=> test_case_51
  [[5, 3], [5,10,12,6,3]], #=> test_case_52
  [[5, 4], [5,10,12,6,8,4]], #=> test_case_53
  [[5, 6], [5,10,12,6]], #=> test_case_54
  [[5, 7], [5,7]], #=> test_case_55
  [[5, 8], [5,10,12,6,8]], #=> test_case_56
  [[5, 9], [5,7,9]], #=> test_case_57
  [[6, 1], [6,8,4,2,1]], #=> test_case_58
  [[6, 2], [6,8,4,2]], #=> test_case_59
  [[6, 3], [6,3]], #=> test_case_60
  [[6, 4], [6,8,4]], #=> test_case_61
  [[6, 5], [6,3,5]], #=> test_case_62
  [[6, 7], [6,12,14,7]], #=> test_case_63
  [[6, 8], [6,8]], #=> test_case_64
  [[6, 9], [6,12,14,7,9]], #=> test_case_65
  [[7, 1], [7,14,16,8,4,2,1]], #=> test_case_66
  [[7, 2], [7,14,16,8,4,2]], #=> test_case_67
  [[7, 3], [7,14,16,8,4,6,3]], #=> test_case_68
  [[7, 4], [7,14,16,8,4]], #=> test_case_69
  [[7, 5], [7,14,16,8,10,5]], #=> test_case_70
  [[7, 6], [7,14,16,8,4,6]], #=> test_case_71
  [[7, 8], [7,14,16,8]], #=> test_case_72
  [[7, 9], [7,9]], #=> test_case_73
  [[8, 1], [8,4,2,1]], #=> test_case_74
  [[8, 2], [8,4,2]], #=> test_case_75
  [[8, 3], [8,4,6,3]], #=> test_case_76
  [[8, 4], [8,4]], #=> test_case_77
  [[8, 5], [8,10,5]], #=> test_case_78
  [[8, 6], [8,4,6]], #=> test_case_79
  [[8, 7], [8,10,5,7]], #=> test_case_80
  [[8, 9], [8,16,18,9]], #=> test_case_81
  [[9, 1], [9,11,22,24,12,6,8,4,2,1]], #=> test_case_82
  [[9, 2], [9,11,22,24,12,6,8,4,2]], #=> test_case_83
  [[9, 3], [9,11,22,24,12,6,3]], #=> test_case_84
  [[9, 4], [9,11,22,24,12,6,8,4]], #=> test_case_85
  [[9, 5], [9,18,20,10,5]], #=> test_case_86
  [[9, 6], [9,11,22,24,12,6]], #=> test_case_87
  [[9, 7], [9,18,20,10,5,7]], #=> test_case_88
  [[9, 8], [9,11,22,24,12,6,8]], #=> test_case_89
  [[0, 100], [0,2,4,6,12,24,48,50,100]], #=> test_case_90
  [[0, 200], [0,2,4,6,12,24,48,50,100,200]], #=> test_case_91
  [[0, 300], [0,2,4,8,16,18,36,72,74,148,150,300]], #=> test_case_92
  [[0, 400], [0,2,4,6,12,24,48,50,100,200,400]], #=> test_case_93
  [[0, 500], [0,2,4,6,12,14,28,30,60,62,124,248,250,500]], #=> test_case_94
  [[0, 600], [0,2,4,8,16,18,36,72,74,148,150,300,600]], #=> test_case_95
  [[0, 700], [0,2,4,8,10,20,40,42,84,86,172,174,348,350,700]], #=> test_case_96
  [[0, 800], [0,2,4,6,12,24,48,50,100,200,400,800]], #=> test_case_97
  [[0, 900], [0,2,4,6,12,14,28,56,112,224,448,450,900]], #=> test_case_98
  [[1, 100], [1,3,6,12,24,48,50,100]], #=> test_case_99
  [[100, 1], [100,50,52,26,28,14,16,8,4,2,1]], #=> test_case_100
  [[1, 200], [1,3,6,12,24,48,50,100,200]], #=> test_case_101
  [[200, 1], [200,100,50,52,26,28,14,16,8,4,2,1]], #=> test_case_102
  [[1, 300], [1,2,4,8,16,18,36,72,74,148,150,300]], #=> test_case_103
  [[300, 1], [300,150,152,76,38,40,20,10,12,6,8,4,2,1]], #=> test_case_104
  [[1, 400], [1,3,6,12,24,48,50,100,200,400]], #=> test_case_105
  [[400, 1], [400,200,100,50,52,26,28,14,16,8,4,2,1]], #=> test_case_106
  [[1, 500], [1,3,5,7,14,28,30,60,62,124,248,250,500]], #=> test_case_107
  [[500, 1], [500,250,252,126,128,64,32,16,8,4,2,1]], #=> test_case_108
  [[1, 600], [1,2,4,8,16,18,36,72,74,148,150,300,600]], #=> test_case_109
  [[600, 1], [600,300,150,152,76,38,40,20,10,12,6,8,4,2,1]], #=> test_case_110
  [[1, 700], [1,3,5,10,20,40,42,84,86,172,174,348,350,700]], #=> test_case_111
  [[700, 1], [700,350,352,176,88,44,22,24,12,6,8,4,2,1]], #=> test_case_112
  [[1, 800], [1,3,6,12,24,48,50,100,200,400,800]], #=> test_case_113
  [[800, 1], [800,400,200,100,50,52,26,28,14,16,8,4,2,1]], #=> test_case_114
  [[1, 900], [1,3,5,7,14,28,56,112,224,448,450,900]], #=> test_case_115
  [[900, 1], [900,450,452,226,228,114,116,58,60,30,32,16,8,4,2,1]], #=> test_case_116
  [[2, 100], [2,4,6,12,24,48,50,100]], #=> test_case_117
  [[100, 2], [100,50,52,26,28,14,16,8,4,2]], #=> test_case_118
  [[2, 200], [2,4,6,12,24,48,50,100,200]], #=> test_case_119
  [[200, 2], [200,100,50,52,26,28,14,16,8,4,2]], #=> test_case_120
  [[2, 300], [2,4,8,16,18,36,72,74,148,150,300]], #=> test_case_121
  [[300, 2], [300,150,152,76,38,40,20,10,12,6,8,4,2]], #=> test_case_122
  [[2, 400], [2,4,6,12,24,48,50,100,200,400]], #=> test_case_123
  [[400, 2], [400,200,100,50,52,26,28,14,16,8,4,2]], #=> test_case_124
  [[2, 500], [2,4,6,12,14,28,30,60,62,124,248,250,500]], #=> test_case_125
  [[500, 2], [500,250,252,126,128,64,32,16,8,4,2]], #=> test_case_126
  [[2, 600], [2,4,8,16,18,36,72,74,148,150,300,600]], #=> test_case_127
  [[600, 2], [600,300,150,152,76,38,40,20,10,12,6,8,4,2]], #=> test_case_128
  [[2, 700], [2,4,8,10,20,40,42,84,86,172,174,348,350,700]], #=> test_case_129
  [[700, 2], [700,350,352,176,88,44,22,24,12,6,8,4,2]], #=> test_case_130
  [[2, 800], [2,4,6,12,24,48,50,100,200,400,800]], #=> test_case_131
  [[800, 2], [800,400,200,100,50,52,26,28,14,16,8,4,2]], #=> test_case_132
  [[2, 900], [2,4,6,12,14,28,56,112,224,448,450,900]], #=> test_case_133
  [[900, 2], [900,450,452,226,228,114,116,58,60,30,32,16,8,4,2]], #=> test_case_134
  [[3, 100], [3,6,12,24,48,50,100]], #=> test_case_135
  [[100, 3], [100,50,52,26,28,14,16,8,4,6,3]], #=> test_case_136
  [[3, 200], [3,6,12,24,48,50,100,200]], #=> test_case_137
  [[200, 3], [200,100,50,52,26,28,14,16,8,4,6,3]], #=> test_case_138
  [[3, 300], [3,5,7,9,18,36,72,74,148,150,300]], #=> test_case_139
  [[300, 3], [300,150,152,76,38,40,20,10,12,6,3]], #=> test_case_140
  [[3, 400], [3,6,12,24,48,50,100,200,400]], #=> test_case_141
  [[400, 3], [400,200,100,50,52,26,28,14,16,8,4,6,3]], #=> test_case_142
  [[3, 500], [3,5,7,14,28,30,60,62,124,248,250,500]], #=> test_case_143
  [[500, 3], [500,250,252,126,128,64,32,16,8,4,6,3]], #=> test_case_144
  [[3, 600], [3,5,7,9,18,36,72,74,148,150,300,600]], #=> test_case_145
  [[600, 3], [600,300,150,152,76,38,40,20,10,12,6,3]], #=> test_case_146
  [[3, 700], [3,5,10,20,40,42,84,86,172,174,348,350,700]], #=> test_case_147
  [[700, 3], [700,350,352,176,88,44,22,24,12,6,3]], #=> test_case_148
  [[3, 800], [3,6,12,24,48,50,100,200,400,800]], #=> test_case_149
  [[800, 3], [800,400,200,100,50,52,26,28,14,16,8,4,6,3]], #=> test_case_150
  [[3, 900], [3,5,7,14,28,56,112,224,448,450,900]], #=> test_case_151
  [[900, 3], [900,450,452,226,228,114,116,58,60,30,32,16,8,4,6,3]], #=> test_case_152
  [[4, 100], [4,6,12,24,48,50,100]], #=> test_case_153
  [[100, 4], [100,50,52,26,28,14,16,8,4]], #=> test_case_154
  [[4, 200], [4,6,12,24,48,50,100,200]], #=> test_case_155
  [[200, 4], [200,100,50,52,26,28,14,16,8,4]], #=> test_case_156
  [[4, 300], [4,8,16,18,36,72,74,148,150,300]], #=> test_case_157
  [[300, 4], [300,150,152,76,38,40,20,10,12,6,8,4]], #=> test_case_158
  [[4, 400], [4,6,12,24,48,50,100,200,400]], #=> test_case_159
  [[400, 4], [400,200,100,50,52,26,28,14,16,8,4]], #=> test_case_160
  [[4, 500], [4,6,12,14,28,30,60,62,124,248,250,500]], #=> test_case_161
  [[500, 4], [500,250,252,126,128,64,32,16,8,4]], #=> test_case_162
  [[4, 600], [4,8,16,18,36,72,74,148,150,300,600]], #=> test_case_163
  [[600, 4], [600,300,150,152,76,38,40,20,10,12,6,8,4]], #=> test_case_164
  [[4, 700], [4,8,10,20,40,42,84,86,172,174,348,350,700]], #=> test_case_165
  [[700, 4], [700,350,352,176,88,44,22,24,12,6,8,4]], #=> test_case_166
  [[4, 800], [4,6,12,24,48,50,100,200,400,800]], #=> test_case_167
  [[800, 4], [800,400,200,100,50,52,26,28,14,16,8,4]], #=> test_case_168
  [[4, 900], [4,6,12,14,28,56,112,224,448,450,900]], #=> test_case_169
  [[900, 4], [900,450,452,226,228,114,116,58,60,30,32,16,8,4]], #=> test_case_170
  [[5, 100], [5,10,12,24,48,50,100]], #=> test_case_171
  [[100, 5], [100,50,52,26,28,14,16,8,10,5]], #=> test_case_172
  [[5, 200], [5,10,12,24,48,50,100,200]], #=> test_case_173
  [[200, 5], [200,100,50,52,26,28,14,16,8,10,5]], #=> test_case_174
  [[5, 300], [5,7,9,18,36,72,74,148,150,300]], #=> test_case_175
  [[300, 5], [300,150,152,76,38,40,20,10,5]], #=> test_case_176
  [[5, 400], [5,10,12,24,48,50,100,200,400]], #=> test_case_177
  [[400, 5], [400,200,100,50,52,26,28,14,16,8,10,5]], #=> test_case_178
  [[5, 500], [5,7,14,28,30,60,62,124,248,250,500]], #=> test_case_179
  [[500, 5], [500,250,252,126,128,64,32,16,8,10,5]], #=> test_case_180
  [[5, 600], [5,7,9,18,36,72,74,148,150,300,600]], #=> test_case_181
  [[600, 5], [600,300,150,152,76,38,40,20,10,5]], #=> test_case_182
  [[5, 700], [5,10,20,40,42,84,86,172,174,348,350,700]], #=> test_case_183
  [[700, 5], [700,350,352,176,88,44,22,24,12,6,3,5]], #=> test_case_184
  [[5, 800], [5,10,12,24,48,50,100,200,400,800]], #=> test_case_185
  [[800, 5], [800,400,200,100,50,52,26,28,14,16,8,10,5]], #=> test_case_186
  [[5, 900], [5,7,14,28,56,112,224,448,450,900]], #=> test_case_187
  [[900, 5], [900,450,452,226,228,114,116,58,60,30,32,16,8,10,5]], #=> test_case_188
  [[6, 100], [6,12,24,48,50,100]], #=> test_case_189
  [[100, 6], [100,50,52,26,28,14,16,8,4,6]], #=> test_case_190
  [[6, 200], [6,12,24,48,50,100,200]], #=> test_case_191
  [[200, 6], [200,100,50,52,26,28,14,16,8,4,6]], #=> test_case_192
  [[6, 300], [6,8,16,18,36,72,74,148,150,300]], #=> test_case_193
  [[300, 6], [300,150,152,76,38,40,20,10,12,6]], #=> test_case_194
  [[6, 400], [6,12,24,48,50,100,200,400]], #=> test_case_195
  [[400, 6], [400,200,100,50,52,26,28,14,16,8,4,6]], #=> test_case_196
  [[6, 500], [6,12,14,28,30,60,62,124,248,250,500]], #=> test_case_197
  [[500, 6], [500,250,252,126,128,64,32,16,8,4,6]], #=> test_case_198
  [[6, 600], [6,8,16,18,36,72,74,148,150,300,600]], #=> test_case_199
  [[600, 6], [600,300,150,152,76,38,40,20,10,12,6]], #=> test_case_200
  [[6, 700], [6,8,10,20,40,42,84,86,172,174,348,350,700]], #=> test_case_201
  [[700, 6], [700,350,352,176,88,44,22,24,12,6]], #=> test_case_202
  [[6, 800], [6,12,24,48,50,100,200,400,800]], #=> test_case_203
  [[800, 6], [800,400,200,100,50,52,26,28,14,16,8,4,6]], #=> test_case_204
  [[6, 900], [6,12,14,28,56,112,224,448,450,900]], #=> test_case_205
  [[900, 6], [900,450,452,226,228,114,116,58,60,30,32,16,8,4,6]], #=> test_case_206
  [[7, 100], [7,9,11,22,24,48,50,100]], #=> test_case_207
  [[100, 7], [100,50,52,26,28,14,7]], #=> test_case_208
  [[7, 200], [7,9,11,22,24,48,50,100,200]], #=> test_case_209
  [[200, 7], [200,100,50,52,26,28,14,7]], #=> test_case_210
  [[7, 300], [7,9,18,36,72,74,148,150,300]], #=> test_case_211
  [[300, 7], [300,150,152,76,38,40,20,10,5,7]], #=> test_case_212
  [[7, 400], [7,9,11,22,24,48,50,100,200,400]], #=> test_case_213
  [[400, 7], [400,200,100,50,52,26,28,14,7]], #=> test_case_214
  [[7, 500], [7,14,28,30,60,62,124,248,250,500]], #=> test_case_215
  [[500, 7], [500,250,252,126,128,64,32,16,8,10,5,7]], #=> test_case_216
  [[7, 600], [7,9,18,36,72,74,148,150,300,600]], #=> test_case_217
  [[600, 7], [600,300,150,152,76,38,40,20,10,5,7]], #=> test_case_218
  [[7, 700], [7,9,18,20,40,42,84,86,172,174,348,350,700]], #=> test_case_219
  [[700, 7], [700,350,352,176,88,44,22,24,12,14,7]], #=> test_case_220
  [[7, 800], [7,9,11,22,24,48,50,100,200,400,800]], #=> test_case_221
  [[800, 7], [800,400,200,100,50,52,26,28,14,7]], #=> test_case_222
  [[7, 900], [7,14,28,56,112,224,448,450,900]], #=> test_case_223
  [[900, 7], [900,450,452,226,228,114,116,58,60,30,32,16,8,10,5,7]], #=> test_case_224
  [[8, 100], [8,10,12,24,48,50,100]], #=> test_case_225
  [[100, 8], [100,50,52,26,28,14,16,8]], #=> test_case_226
  [[8, 200], [8,10,12,24,48,50,100,200]], #=> test_case_227
  [[200, 8], [200,100,50,52,26,28,14,16,8]], #=> test_case_228
  [[8, 300], [8,16,18,36,72,74,148,150,300]], #=> test_case_229
  [[300, 8], [300,150,152,76,38,40,20,10,12,6,8]], #=> test_case_230
  [[8, 400], [8,10,12,24,48,50,100,200,400]], #=> test_case_231
  [[400, 8], [400,200,100,50,52,26,28,14,16,8]], #=> test_case_232
  [[8, 500], [8,10,12,14,28,30,60,62,124,248,250,500]], #=> test_case_233
  [[500, 8], [500,250,252,126,128,64,32,16,8]], #=> test_case_234
  [[8, 600], [8,16,18,36,72,74,148,150,300,600]], #=> test_case_235
  [[600, 8], [600,300,150,152,76,38,40,20,10,12,6,8]], #=> test_case_236
  [[8, 700], [8,10,20,40,42,84,86,172,174,348,350,700]], #=> test_case_237
  [[700, 8], [700,350,352,176,88,44,22,24,12,6,8]], #=> test_case_238
  [[8, 800], [8,10,12,24,48,50,100,200,400,800]], #=> test_case_239
  [[800, 8], [800,400,200,100,50,52,26,28,14,16,8]], #=> test_case_240
  [[8, 900], [8,10,12,14,28,56,112,224,448,450,900]], #=> test_case_241
  [[900, 8], [900,450,452,226,228,114,116,58,60,30,32,16,8]], #=> test_case_242
  [[9, 100], [9,11,22,24,48,50,100]], #=> test_case_243
  [[100, 9], [100,50,52,26,28,14,7,9]], #=> test_case_244
  [[9, 200], [9,11,22,24,48,50,100,200]], #=> test_case_245
  [[200, 9], [200,100,50,52,26,28,14,7,9]], #=> test_case_246
  [[9, 300], [9,18,36,72,74,148,150,300]], #=> test_case_247
  [[300, 9], [300,150,152,76,38,40,20,10,5,7,9]], #=> test_case_248
  [[9, 400], [9,11,22,24,48,50,100,200,400]], #=> test_case_249
  [[400, 9], [400,200,100,50,52,26,28,14,7,9]], #=> test_case_250
  [[9, 500], [9,11,13,15,30,60,62,124,248,250,500]], #=> test_case_251
  [[500, 9], [500,250,252,126,128,64,32,16,18,9]], #=> test_case_252
  [[9, 600], [9,18,36,72,74,148,150,300,600]], #=> test_case_253
  [[600, 9], [600,300,150,152,76,38,40,20,10,5,7,9]], #=> test_case_254
  [[9, 700], [9,18,20,40,42,84,86,172,174,348,350,700]], #=> test_case_255
  [[700, 9], [700,350,352,176,88,44,22,24,12,14,7,9]], #=> test_case_256
  [[9, 800], [9,11,22,24,48,50,100,200,400,800]], #=> test_case_257
  [[800, 9], [800,400,200,100,50,52,26,28,14,7,9]], #=> test_case_258
  [[9, 900], [9,11,13,26,28,56,112,224,448,450,900]], #=> test_case_259
  [[900, 9], [900,450,452,226,228,114,116,58,60,30,32,16,18,9]], #=> test_case_260
  [[159, 160], [159,318,320,160]], #=> test_case_261
  [[159, 161], [159,161]], #=> test_case_262
  [[159, 162], [159,161,322,324,162]], #=> test_case_263
  [[159, 164], [159,161,163,326,328,164]], #=> test_case_264
  [[159, 169], [159,161,163,165,167,169]], #=> test_case_265
  [[160, 161], [160,320,322,161]], #=> test_case_266
  [[160, 162], [160,162]], #=> test_case_267
  [[160, 163], [160,162,324,326,163]], #=> test_case_268
  [[160, 165], [160,162,164,328,330,165]], #=> test_case_269
  [[160, 170], [160,162,164,166,168,170]], #=> test_case_270
  [[161, 162], [161,322,324,162]], #=> test_case_271
  [[161, 163], [161,163]], #=> test_case_272
  [[161, 164], [161,163,326,328,164]], #=> test_case_273
  [[161, 166], [161,163,165,330,332,166]], #=> test_case_274
  [[161, 171], [161,163,165,167,169,171]], #=> test_case_275
  [[162, 163], [162,324,326,163]], #=> test_case_276
  [[162, 164], [162,164]], #=> test_case_277
  [[162, 165], [162,164,328,330,165]], #=> test_case_278
  [[162, 167], [162,164,166,332,334,167]], #=> test_case_279
  [[162, 172], [162,164,166,168,170,172]], #=> test_case_280
  [[163, 164], [163,326,328,164]], #=> test_case_281
  [[163, 165], [163,165]], #=> test_case_282
  [[163, 166], [163,165,330,332,166]], #=> test_case_283
  [[163, 168], [163,165,167,334,336,168]], #=> test_case_284
  [[163, 173], [163,165,167,169,171,173]], #=> test_case_285
  [[164, 165], [164,328,330,165]], #=> test_case_286
  [[164, 166], [164,166]], #=> test_case_287
  [[164, 167], [164,166,332,334,167]], #=> test_case_288
  [[164, 169], [164,166,168,336,338,169]], #=> test_case_289
  [[164, 174], [164,166,168,170,172,174]], #=> test_case_290
  [[165, 166], [165,330,332,166]], #=> test_case_291
  [[165, 167], [165,167]], #=> test_case_292
  [[165, 168], [165,167,334,336,168]], #=> test_case_293
  [[165, 170], [165,167,169,338,340,170]], #=> test_case_294
  [[165, 175], [165,167,169,171,173,175]], #=> test_case_295
  [[166, 167], [166,332,334,167]], #=> test_case_296
  [[166, 168], [166,168]], #=> test_case_297
  [[166, 169], [166,168,336,338,169]], #=> test_case_298
  [[166, 171], [166,168,170,340,342,171]], #=> test_case_299
  [[166, 176], [166,168,170,172,174,176]], #=> test_case_300
  [[167, 168], [167,334,336,168]], #=> test_case_301
  [[167, 169], [167,169]], #=> test_case_302
  [[167, 170], [167,169,338,340,170]], #=> test_case_303
  [[167, 172], [167,169,171,342,344,172]], #=> test_case_304
  [[167, 177], [167,169,171,173,175,177]], #=> test_case_305
  [[168, 169], [168,336,338,169]], #=> test_case_306
  [[168, 170], [168,170]], #=> test_case_307
  [[168, 171], [168,170,340,342,171]], #=> test_case_308
  [[168, 173], [168,170,172,344,346,173]], #=> test_case_309
  [[168, 178], [168,170,172,174,176,178]], #=> test_case_310
  [[169, 170], [169,338,340,170]], #=> test_case_311
  [[169, 171], [169,171]], #=> test_case_312
  [[169, 172], [169,171,342,344,172]], #=> test_case_313
  [[169, 174], [169,171,173,346,348,174]], #=> test_case_314
  [[169, 179], [169,171,173,175,177,179]], #=> test_case_315
  [[170, 171], [170,340,342,171]], #=> test_case_316
  [[170, 172], [170,172]], #=> test_case_317
  [[170, 173], [170,172,344,346,173]], #=> test_case_318
  [[170, 175], [170,172,174,348,350,175]], #=> test_case_319
  [[170, 180], [170,172,174,176,178,180]], #=> test_case_320
  [[171, 172], [171,342,344,172]], #=> test_case_321
  [[171, 173], [171,173]], #=> test_case_322
  [[171, 174], [171,173,346,348,174]], #=> test_case_323
  [[171, 176], [171,173,175,350,352,176]], #=> test_case_324
  [[171, 181], [171,173,175,177,179,181]], #=> test_case_325
  [[172, 173], [172,344,346,173]], #=> test_case_326
  [[172, 174], [172,174]], #=> test_case_327
  [[172, 175], [172,174,348,350,175]], #=> test_case_328
  [[172, 177], [172,174,176,352,354,177]], #=> test_case_329
  [[172, 182], [172,174,176,178,180,182]], #=> test_case_330
  [[173, 174], [173,346,348,174]], #=> test_case_331
  [[173, 175], [173,175]], #=> test_case_332
  [[173, 176], [173,175,350,352,176]], #=> test_case_333
  [[173, 178], [173,175,177,354,356,178]], #=> test_case_334
  [[173, 183], [173,175,177,179,181,183]], #=> test_case_335
  [[174, 175], [174,348,350,175]], #=> test_case_336
  [[174, 176], [174,176]], #=> test_case_337
  [[174, 177], [174,176,352,354,177]], #=> test_case_338
  [[174, 179], [174,176,178,356,358,179]], #=> test_case_339
  [[174, 184], [174,176,178,180,182,184]], #=> test_case_340
  [[175, 176], [175,350,352,176]], #=> test_case_341
  [[175, 177], [175,177]], #=> test_case_342
  [[175, 178], [175,177,354,356,178]], #=> test_case_343
  [[175, 180], [175,177,179,358,360,180]], #=> test_case_344
  [[175, 185], [175,177,179,181,183,185]], #=> test_case_345
  [[176, 177], [176,352,354,177]], #=> test_case_346
  [[176, 178], [176,178]], #=> test_case_347
  [[176, 179], [176,178,356,358,179]], #=> test_case_348
  [[176, 181], [176,178,180,360,362,181]], #=> test_case_349
  [[176, 186], [176,178,180,182,184,186]], #=> test_case_350
  [[177, 178], [177,354,356,178]], #=> test_case_351
  [[177, 179], [177,179]], #=> test_case_352
  [[177, 180], [177,179,358,360,180]], #=> test_case_353
  [[177, 182], [177,179,181,362,364,182]], #=> test_case_354
  [[177, 187], [177,179,181,183,185,187]], #=> test_case_355
  [[178, 179], [178,356,358,179]], #=> test_case_356
  [[178, 180], [178,180]], #=> test_case_357
  [[178, 181], [178,180,360,362,181]], #=> test_case_358
  [[178, 183], [178,180,182,364,366,183]], #=> test_case_359
  [[178, 188], [178,180,182,184,186,188]], #=> test_case_360
  [[159, 158], [159,318,320,160,80,40,20,10,12,14,16,18,36,38,76,78,156,158]], #=> test_case_361
  [[159, 157], [159,318,320,160,80,40,20,10,5,7,9,18,36,38,76,78,156,312,314,157]], #=> test_case_362
  [[159, 156], [159,318,320,160,80,40,20,22,11,13,15,17,19,38,76,78,156]], #=> test_case_363
  [[159, 154], [159,318,320,160,80,40,20,10,5,7,9,18,36,38,76,152,154]], #=> test_case_364
  [[159, 149], [159,318,320,160,80,40,20,10,5,7,9,18,36,72,74,148,296,298,149]], #=> test_case_365
  [[160, 159], [160,80,40,20,10,5,7,9,18,36,38,76,78,156,312,314,157,159]], #=> test_case_366
  [[160, 158], [160,80,40,20,10,12,14,16,18,36,38,76,78,156,158]], #=> test_case_367
  [[160, 157], [160,80,40,20,10,12,14,16,18,36,38,76,78,156,312,314,157]], #=> test_case_368
  [[160, 155], [160,80,40,20,10,5,7,9,18,36,38,76,152,154,308,310,155]], #=> test_case_369
  [[160, 150], [160,80,40,20,10,12,14,16,18,36,72,74,148,150]], #=> test_case_370
  [[161, 160], [161,163,326,328,164,82,84,42,44,22,24,12,14,16,18,20,40,80,160]], #=> test_case_371
  [[161, 159], [161,322,324,162,164,82,84,42,44,22,11,13,15,17,19,38,76,78,156,312,314,157,159]], #=> test_case_372
  [[161, 158], [161,163,326,328,164,82,84,42,44,22,11,13,15,17,19,38,76,78,156,158]], #=> test_case_373
  [[161, 156], [161,322,324,162,164,82,84,42,44,22,11,13,15,17,19,38,76,78,156]], #=> test_case_374
  [[161, 151], [161,163,326,328,164,82,84,42,44,22,24,12,14,16,18,36,72,74,148,150,300,302,151]], #=> test_case_375
  [[162, 161], [162,164,82,84,42,44,22,24,12,6,8,10,20,40,80,160,320,322,161]], #=> test_case_376
  [[162, 160], [162,164,82,84,42,44,22,11,13,15,17,19,38,40,80,160]], #=> test_case_377
  [[162, 159], [162,164,82,84,42,44,22,11,13,15,17,19,38,76,78,156,312,314,157,159]], #=> test_case_378
  [[162, 157], [162,164,82,84,42,44,22,11,13,15,17,19,38,76,78,156,312,314,157]], #=> test_case_379
  [[162, 152], [162,164,82,84,42,44,22,11,13,15,17,19,38,76,152]], #=> test_case_380
  [[163, 162], [163,326,328,164,82,84,42,44,22,11,13,15,17,19,38,40,80,160,162]], #=> test_case_381
  [[163, 161], [163,326,328,164,82,84,42,44,22,24,12,14,16,18,20,40,80,160,320,322,161]], #=> test_case_382
  [[163, 160], [163,326,328,164,82,84,42,44,22,24,12,14,16,18,20,40,80,160]], #=> test_case_383
  [[163, 158], [163,326,328,164,82,84,42,44,22,11,13,15,17,19,38,76,78,156,158]], #=> test_case_384
  [[163, 153], [163,326,328,164,82,84,42,44,22,11,13,15,17,19,38,76,152,304,306,153]], #=> test_case_385
  [[164, 163], [164,82,84,42,44,22,11,13,15,17,19,38,40,80,160,320,322,161,163]], #=> test_case_386
  [[164, 162], [164,82,84,42,44,22,11,13,15,17,19,38,40,80,160,162]], #=> test_case_387
  [[164, 161], [164,82,84,42,44,22,24,12,6,8,10,20,40,80,160,320,322,161]], #=> test_case_388
  [[164, 159], [164,82,84,42,44,22,11,13,15,17,19,38,76,78,156,312,314,157,159]], #=> test_case_389
  [[164, 154], [164,82,84,42,44,22,11,13,15,17,19,38,76,152,154]], #=> test_case_390
  [[165, 164], [165,167,334,336,168,84,42,44,22,24,12,14,16,18,20,40,80,82,164]], #=> test_case_391
  [[165, 163], [165,330,332,166,168,84,42,44,22,24,12,14,16,18,20,40,80,160,162,324,326,163]], #=> test_case_392
  [[165, 162], [165,167,334,336,168,84,42,44,22,11,13,15,17,19,38,40,80,160,162]], #=> test_case_393
  [[165, 160], [165,167,334,336,168,84,42,44,22,11,13,15,17,19,38,40,80,160]], #=> test_case_394
  [[165, 155], [165,330,332,166,168,84,42,44,22,11,13,15,17,19,38,76,152,304,306,153,155]], #=> test_case_395
  [[166, 165], [166,168,84,42,44,22,11,13,15,17,19,38,40,80,82,164,328,330,165]], #=> test_case_396
  [[166, 164], [166,168,84,42,44,22,11,13,15,17,19,38,40,80,82,164]], #=> test_case_397
  [[166, 163], [166,168,84,42,44,22,11,13,15,17,19,38,40,80,160,162,324,326,163]], #=> test_case_398
  [[166, 161], [166,168,84,42,44,22,11,13,15,17,19,38,40,80,160,320,322,161]], #=> test_case_399
  [[166, 156], [166,168,84,42,44,22,11,13,15,17,19,38,76,78,156]], #=> test_case_400
  [[167, 166], [167,334,336,168,84,42,44,22,11,13,15,17,19,38,40,80,82,164,166]], #=> test_case_401
  [[167, 165], [167,334,336,168,84,42,44,22,11,13,15,17,19,38,40,80,82,164,328,330,165]], #=> test_case_402
  [[167, 164], [167,334,336,168,84,42,44,22,11,13,15,17,19,38,40,80,82,164]], #=> test_case_403
  [[167, 162], [167,334,336,168,84,42,44,22,11,13,15,17,19,38,40,80,160,162]], #=> test_case_404
  [[167, 157], [167,334,336,168,84,42,44,22,11,13,15,17,19,38,76,78,156,312,314,157]], #=> test_case_405
  [[168, 167], [168,84,42,44,22,11,13,15,17,19,38,40,80,82,164,328,330,165,167]], #=> test_case_406
  [[168, 166], [168,84,42,44,22,11,13,15,17,19,38,40,80,82,164,166]], #=> test_case_407
  [[168, 165], [168,84,42,44,22,11,13,15,17,19,38,40,80,82,164,328,330,165]], #=> test_case_408
  [[168, 163], [168,84,42,44,22,11,13,15,17,19,38,40,80,160,162,324,326,163]], #=> test_case_409
  [[168, 158], [168,84,42,44,22,11,13,15,17,19,38,76,78,156,158]], #=> test_case_410
  [[169, 168], [169,171,342,344,172,86,88,44,22,11,13,15,17,19,21,42,84,168]], #=> test_case_411
  [[169, 167], [169,338,340,170,172,86,88,44,22,24,12,6,8,10,20,40,80,82,164,328,330,165,167]], #=> test_case_412
  [[169, 166], [169,171,342,344,172,86,88,44,22,24,12,6,8,10,20,40,80,82,164,166]], #=> test_case_413
  [[169, 164], [169,171,342,344,172,86,88,44,22,11,13,15,17,19,38,40,80,82,164]], #=> test_case_414
  [[169, 159], [169,338,340,170,172,86,88,44,22,11,13,15,17,19,38,76,78,156,312,314,157,159]], #=> test_case_415
  [[170, 169], [170,172,86,88,44,22,11,13,15,17,19,21,42,84,168,336,338,169]], #=> test_case_416
  [[170, 168], [170,172,86,88,44,22,11,13,15,17,19,21,42,84,168]], #=> test_case_417
  [[170, 167], [170,172,86,88,44,22,24,12,14,16,18,20,40,80,82,164,328,330,165,167]], #=> test_case_418
  [[170, 165], [170,172,86,88,44,22,24,12,14,16,18,20,40,80,82,164,328,330,165]], #=> test_case_419
  [[170, 160], [170,172,86,88,44,22,11,13,15,17,19,38,40,80,160]], #=> test_case_420
  [[171, 170], [171,342,344,172,86,88,44,22,11,13,15,17,19,21,42,84,168,170]], #=> test_case_421
  [[171, 169], [171,342,344,172,86,88,44,22,11,13,15,17,19,21,42,84,168,336,338,169]], #=> test_case_422
  [[171, 168], [171,342,344,172,86,88,44,22,11,13,15,17,19,21,42,84,168]], #=> test_case_423
  [[171, 166], [171,342,344,172,86,88,44,22,11,13,15,17,19,38,40,80,82,164,166]], #=> test_case_424
  [[171, 161], [171,342,344,172,86,88,44,22,24,12,6,8,10,20,40,80,160,320,322,161]], #=> test_case_425
  [[172, 171], [172,86,88,44,22,11,13,15,17,19,21,42,84,168,336,338,169,171]], #=> test_case_426
  [[172, 170], [172,86,88,44,22,11,13,15,17,19,21,42,84,168,170]], #=> test_case_427
  [[172, 169], [172,86,88,44,22,11,13,15,17,19,21,42,84,168,336,338,169]], #=> test_case_428
  [[172, 167], [172,86,88,44,22,24,12,14,16,18,20,40,80,82,164,328,330,165,167]], #=> test_case_429
  [[172, 162], [172,86,88,44,22,11,13,15,17,19,38,40,80,160,162]], #=> test_case_430
  [[173, 172], [173,175,350,352,176,88,44,22,11,13,15,17,19,21,42,84,86,172]], #=> test_case_431
  [[173, 171], [173,175,350,352,176,88,44,22,11,13,15,17,19,21,42,84,168,336,338,169,171]], #=> test_case_432
  [[173, 170], [173,346,348,174,176,88,44,22,11,13,15,17,19,21,42,84,168,170]], #=> test_case_433
  [[173, 168], [173,175,350,352,176,88,44,22,11,13,15,17,19,21,42,84,168]], #=> test_case_434
  [[173, 163], [173,346,348,174,176,88,44,22,11,13,15,17,19,38,40,80,160,320,322,161,163]], #=> test_case_435
  [[174, 173], [174,176,88,44,22,11,13,15,17,19,21,42,84,86,172,344,346,173]], #=> test_case_436
  [[174, 172], [174,176,88,44,22,11,13,15,17,19,21,42,84,86,172]], #=> test_case_437
  [[174, 171], [174,176,88,44,22,11,13,15,17,19,21,42,84,168,336,338,169,171]], #=> test_case_438
  [[174, 169], [174,176,88,44,22,11,13,15,17,19,21,42,84,168,336,338,169]], #=> test_case_439
  [[174, 164], [174,176,88,44,22,11,13,15,17,19,38,40,80,82,164]], #=> test_case_440
  [[175, 174], [175,350,352,176,88,44,22,11,13,15,17,19,21,42,84,86,172,174]], #=> test_case_441
  [[175, 173], [175,350,352,176,88,44,22,11,13,15,17,19,21,42,84,86,172,344,346,173]], #=> test_case_442
  [[175, 172], [175,350,352,176,88,44,22,11,13,15,17,19,21,42,84,86,172]], #=> test_case_443
  [[175, 170], [175,350,352,176,88,44,22,11,13,15,17,19,21,42,84,168,170]], #=> test_case_444
  [[175, 165], [175,350,352,176,88,44,22,11,13,15,17,19,38,40,80,82,164,328,330,165]], #=> test_case_445
  [[176, 175], [176,88,44,22,11,13,15,17,19,21,42,84,86,172,344,346,173,175]], #=> test_case_446
  [[176, 174], [176,88,44,22,11,13,15,17,19,21,42,84,86,172,174]], #=> test_case_447
  [[176, 173], [176,88,44,22,11,13,15,17,19,21,42,84,86,172,344,346,173]], #=> test_case_448
  [[176, 171], [176,88,44,22,11,13,15,17,19,21,42,84,168,170,340,342,171]], #=> test_case_449
  [[176, 166], [176,88,44,22,11,13,15,17,19,38,40,80,82,164,166]], #=> test_case_450
  [[177, 176], [177,179,358,360,180,90,92,46,48,24,12,14,16,18,20,22,44,88,176]], #=> test_case_451
  [[177, 175], [177,179,358,360,180,90,92,46,48,24,12,14,16,18,20,40,42,84,86,172,344,346,173,175]], #=> test_case_452
  [[177, 174], [177,179,358,360,180,90,92,46,48,24,12,14,16,18,20,40,42,84,86,172,174]], #=> test_case_453
  [[177, 172], [177,179,358,360,180,90,92,46,48,24,26,13,15,17,19,21,42,84,86,172]], #=> test_case_454
  [[177, 167], [177,179,358,360,180,90,92,46,48,24,12,6,8,10,20,40,80,82,164,328,330,165,167]], #=> test_case_455
  [[178, 177], [178,180,90,92,46,48,24,12,6,8,10,20,22,44,88,176,352,354,177]], #=> test_case_456
  [[178, 176], [178,180,90,92,46,48,24,12,14,7,9,11,22,44,88,176]], #=> test_case_457
  [[178, 175], [178,180,90,92,46,48,24,26,13,15,17,19,21,42,84,86,172,174,348,350,175]], #=> test_case_458
  [[178, 173], [178,180,90,92,46,48,24,12,6,8,10,20,40,42,84,86,172,344,346,173]], #=> test_case_459
  [[178, 168], [178,180,90,92,46,48,24,26,13,15,17,19,21,42,84,168]], #=> test_case_460
  [[2, 4], [2,4]], #=> test_case_461
  [[2, 8], [2,4,8]], #=> test_case_462
  [[2, 16], [2,4,8,16]], #=> test_case_463
  [[2, 32], [2,4,8,16,32]], #=> test_case_464
  [[2, 64], [2,4,8,16,32,64]], #=> test_case_465
  [[2, 128], [2,4,8,16,32,64,128]], #=> test_case_466
  [[2, 256], [2,4,8,16,32,64,128,256]], #=> test_case_467
  [[2, 512], [2,4,8,16,32,64,128,256,512]], #=> test_case_468
  [[2, 1024], [2,4,8,16,32,64,128,256,512,1024]], #=> test_case_469
  [[4, 2], [4,2]], #=> test_case_470
  [[8, 2], [8,4,2]], #=> test_case_471
  [[16, 2], [16,8,4,2]], #=> test_case_472
  [[32, 2], [32,16,8,4,2]], #=> test_case_473
  [[64, 2], [64,32,16,8,4,2]], #=> test_case_474
  [[128, 2], [128,64,32,16,8,4,2]], #=> test_case_475
  [[256, 2], [256,128,64,32,16,8,4,2]], #=> test_case_476
  [[512, 2], [512,256,128,64,32,16,8,4,2]], #=> test_case_477
  [[1024, 2], [1024,512,256,128,64,32,16,8,4,2]], #=> test_case_478
  [[23, 29], [23,25,27,29]], #=> test_case_479
  [[23, 479], [23,25,27,29,58,116,118,236,238,476,478,956,958,479]], #=> test_case_480
  [[479, 23], [479,958,960,480,240,120,60,30,15,17,19,21,23]], #=> test_case_481
  [[479, 499], [479,481,483,485,487,489,491,493,495,497,499]] #=> test_case_482
  ]
  
  test_cases.each_with_index do |test_case,i|
    class_def "test_case_#{i}".to_sym do
      result = solve(test_case[0][0],test_case[0][1])
      raise "Invalid Test Case" if not valid?(test_case[0],test_case[1])
      assert valid?(test_case[0],result), "The solution is not valid."
      assert result.length <= test_case[1].length, "A shorter solution is known to exist.
[#{test_case[1].join(',')}]
[#{result.join(',')}]"
      if result.length < test_case[1].length
        puts ''
        puts "Better solution found:" 
        puts "[#{result.join(',')}]"
        puts "[#{test_case[1].join(',')}]"
      end
    end
  end

end