# import matlab.engine
#
# eng = matlab.engine.start_matlab()
# #启动引擎
# # ret = eng.test(matlab.double([2]), matlab.double([6]))
# # #调用xyz.m文件，并输入参数
# # x = ret
# # #返回值结果
# # print(x)
#
#
# eng.main2(nargout=0)
#
# eng.quit()
import matlab.engine
eng = matlab.engine.start_matlab()
filepath='./rawdata'
eng.test(filepath,nargout=0)