+++
title = "python_summary1-import and module"
author = ["holy"]
description = "python code를 처음 보면 나오는 것은 import문이다. import문을 이해할 수 있어야 한다."
date = 2023-06-07T00:00:00+09:00
draft = true
+++

## import {#import}

python code의 첫줄에 가장 많이 볼 수 있는 것은 import문이다. 어떤
code를 보더라도 첫줄에 아래와 같은 import로 시작하는 문장을 볼 수 있다.
형태는 다음과 같다.

```text
import [module]
import [package]
```

예를 들면 다음과 같다.

```python
import numpy as np
```

사람들은 말한다. numpy라는 module을 가져와서 np로 이름을 바꿔서 쓴다고
한다. python은 축약적이기 때문에 숨겨져 있는것을 볼 수 있어야
한다. import는 파일을 load한다. load한다는 말은 문자열로된 파일을 읽고
단어별로 list에 넣은 다음, 각각의 단어를 해석해서 객체를 만드는
작업이다. 즉 위와 같이 load한다는 말은 많은과정이 함축되어 있는
것이다. python에서 `.py로 끝나는 파일은 module` 이라고 하고, `module을
모은 directory를 package` 라고 하는데, import는 module과 package를
load한다. 위에서 load를 정의했듯이 import는 module과 package를 모두
읽을수 있다. 디렉토리에 있는 파일들이나, 파일 하나도 모두 utf-8로된
문자열로 되어 있다. 그래서 parsing해서 객체를 만드는 것이다. .py로
시작되는 파일(module)은 보이지 않는 class로 둘러싸여 있다고
생각하자. 예를 들어서, test.py에 아래와 같은 코드가 있다면,

```text
def test():
  return 3+4
class test2(name):
  __init__(self,name):
  self.name = name
```

파일명에 해당하는 class로 둘러싸여 있다고 생각하면 된다. 아래를 보자.

<div class="verse">

class test:<br>
&nbsp;&nbsp;def test():<br>
&nbsp;&nbsp;&nbsp;return 3+4<br>
&nbsp;class test2(name):<br>
&nbsp;&nbsp;&nbsp;__init__(self,name):<br>
&nbsp;&nbsp;&nbsp;self.name = name<br>

</div>

즉, class안에는 class도 있고 function도 define되어 있는 것이다.

<div class="important">

요약하면, `import문은 객체생성!이라고 생각하면 된다.` 객체 생성이
갑툭튀같은 느낌이 들면, import에 적힌 module이나 package들은
text파일이고, 이 text파일을 읽어서 객체를 만드는 과정이라고 풀어서
이해하면 된다. 예를 들어, import numpy는 numpy라는 객체를 생성해서
numpy.random 이런 식으로 사용할 수 있다.  import numpy as np는
numpy라는 객체를 생성하고 np: numpy라는 symbol table에 등록 한다.
그래서 np.random식으로 사용할 수 있다.

</div>


### import 사용시 궁금한것들 {#import-사용시-궁금한것들}

python에서 programming은 객체를 생성하고, 객체에 있는 data를 method로
처리하는것이다. oop언어나 functional language나 처리방법은 같다.
programming이라는 것은 data를 처리하는 것이다. 예를 들어,1000만명의
몸무게를 적은 data가 있다고 하자. 그런데 실수로 100kg을 더해서
기록했다.  50kg인 사람은 150kg으로 적었다. programming 언어를 사용하면
함수나 method를 사용해서 1000개의 data에 -100kg을 빼는것은 한큐에
처리가 가능하다. 그만큼 function이나 method가 강력한 것이다. 따라서
python에서 객체를 생성하면, 객체에 있는 method가 궁금하다. 어떤
method가 있을까? 이것을 확인할수 있는게 dir()다.

```python
a = 3
print(dir(a))
```

```text
['__abs__', '__add__', '__and__', '__class__', '__cmp__', '__coerce__', '__delattr__', '__div__', '__divmod__', '__doc__', '__float__', '__floordiv__', '__format__', '__getattribute__', '__getnewargs__', '__hash__', '__hex__', '__index__', '__init__', '__int__', '__invert__', '__long__', '__lshift__', '__mod__', '__mul__', '__neg__', '__new__', '__nonzero__', '__oct__', '__or__', '__pos__', '__pow__', '__radd__', '__rand__', '__rdiv__', '__rdivmod__', '__reduce__', '__reduce_ex__', '__repr__', '__rfloordiv__', '__rlshift__', '__rmod__', '__rmul__', '__ror__', '__rpow__', '__rrshift__', '__rshift__', '__rsub__', '__rtruediv__', '__rxor__', '__setattr__', '__sizeof__', '__str__', '__sub__', '__subclasshook__', '__truediv__', '__trunc__', '__xor__', 'bit_length', 'conjugate', 'denominator', 'imag', 'numerator', 'real']
```

위에서 보면 객체의 사용되는 method들을 dir()로 확인할 수 있다. `객체를
생성하는 방식은 python에서는 import로 만들거나 assignment로 만드는데.`
둘다 dirs()로 확인할 수 있다. import로 만드는 객체에 대한 예시는
아래와 같다. 그리고 assignment에 대한 자세한 설명은 [여기]({{< relref "python_summary2_assignment_and_variables" >}})에 있다.

```python
import numpy as np
print(dir(np))
print(np.__file__)
```

```text
['ALLOW_THREADS', 'BUFSIZE', 'CLIP', 'ComplexWarning', 'DataSource', 'ERR_CALL', 'ERR_DEFAULT', 'ERR_DEFAULT2', 'ERR_IGNORE', 'ERR_LOG', 'ERR_PRINT', 'ERR_RAISE', 'ERR_WARN', 'FLOATING_POINT_SUPPORT', 'FPE_DIVIDEBYZERO', 'FPE_INVALID', 'FPE_OVERFLOW', 'FPE_UNDERFLOW', 'False_', 'Inf', 'Infinity', 'MAXDIMS', 'MachAr', 'ModuleDeprecationWarning', 'NAN', 'NINF', 'NZERO', 'NaN', 'NanWarning', 'PINF', 'PZERO', 'PackageLoader', 'RAISE', 'RankWarning', 'SHIFT_DIVIDEBYZERO', 'SHIFT_INVALID', 'SHIFT_OVERFLOW', 'SHIFT_UNDERFLOW', 'ScalarType', 'Tester', 'True_', 'UFUNC_BUFSIZE_DEFAULT', 'UFUNC_PYVALS_NAME', 'WRAP', '__NUMPY_SETUP__', '__all__', '__builtins__', '__config__', '__doc__', '__file__', '__git_revision__', '__name__', '__package__', '__path__', '__version__', '_import_tools', '_mat', 'abs', 'absolute', 'absolute_import', 'add', 'add_docstring', 'add_newdoc', 'add_newdoc_ufunc', 'add_newdocs', 'alen', 'all', 'allclose', 'alltrue', 'alterdot', 'amax', 'amin', 'angle', 'any', 'append', 'apply_along_axis', 'apply_over_axes', 'arange', 'arccos', 'arccosh', 'arcsin', 'arcsinh', 'arctan', 'arctan2', 'arctanh', 'argmax', 'argmin', 'argpartition', 'argsort', 'argwhere', 'around', 'array', 'array2string', 'array_equal', 'array_equiv', 'array_repr', 'array_split', 'array_str', 'asanyarray', 'asarray', 'asarray_chkfinite', 'ascontiguousarray', 'asfarray', 'asfortranarray', 'asmatrix', 'asscalar', 'atleast_1d', 'atleast_2d', 'atleast_3d', 'average', 'bartlett', 'base_repr', 'bench', 'binary_repr', 'bincount', 'bitwise_and', 'bitwise_not', 'bitwise_or', 'bitwise_xor', 'blackman', 'bmat', 'bool', 'bool8', 'bool_', 'broadcast', 'broadcast_arrays', 'busday_count', 'busday_offset', 'busdaycalendar', 'byte', 'byte_bounds', 'bytes_', 'c_', 'can_cast', 'cast', 'cdouble', 'ceil', 'cfloat', 'char', 'character', 'chararray', 'choose', 'clip', 'clongdouble', 'clongfloat', 'column_stack', 'common_type', 'compare_chararrays', 'compat', 'complex', 'complex128', 'complex256', 'complex64', 'complex_', 'complexfloating', 'compress', 'concatenate', 'conj', 'conjugate', 'convolve', 'copy', 'copysign', 'copyto', 'core', 'corrcoef', 'correlate', 'cos', 'cosh', 'count_nonzero', 'cov', 'cross', 'csingle', 'ctypeslib', 'cumprod', 'cumproduct', 'cumsum', 'datetime64', 'datetime_as_string', 'datetime_data', 'deg2rad', 'degrees', 'delete', 'deprecate', 'deprecate_with_doc', 'diag', 'diag_indices', 'diag_indices_from', 'diagflat', 'diagonal', 'diff', 'digitize', 'disp', 'divide', 'division', 'dot', 'double', 'dsplit', 'dstack', 'dtype', 'e', 'ediff1d', 'einsum', 'emath', 'empty', 'empty_like', 'equal', 'errstate', 'euler_gamma', 'exp', 'exp2', 'expand_dims', 'expm1', 'extract', 'eye', 'fabs', 'fastCopyAndTranspose', 'fft', 'fill_diagonal', 'find_common_type', 'finfo', 'fix', 'flatiter', 'flatnonzero', 'flexible', 'fliplr', 'flipud', 'float', 'float128', 'float16', 'float32', 'float64', 'float_', 'floating', 'floor', 'floor_divide', 'fmax', 'fmin', 'fmod', 'format_parser', 'frexp', 'frombuffer', 'fromfile', 'fromfunction', 'fromiter', 'frompyfunc', 'fromregex', 'fromstring', 'full', 'full_like', 'fv', 'generic', 'genfromtxt', 'get_array_wrap', 'get_include', 'get_numarray_include', 'get_printoptions', 'getbuffer', 'getbufsize', 'geterr', 'geterrcall', 'geterrobj', 'gradient', 'greater', 'greater_equal', 'half', 'hamming', 'hanning', 'histogram', 'histogram2d', 'histogramdd', 'hsplit', 'hstack', 'hypot', 'i0', 'identity', 'iinfo', 'imag', 'in1d', 'index_exp', 'indices', 'inexact', 'inf', 'info', 'infty', 'inner', 'insert', 'int', 'int0', 'int16', 'int32', 'int64', 'int8', 'int_', 'int_asbuffer', 'intc', 'integer', 'interp', 'intersect1d', 'intp', 'invert', 'ipmt', 'irr', 'is_busday', 'isclose', 'iscomplex', 'iscomplexobj', 'isfinite', 'isfortran', 'isinf', 'isnan', 'isneginf', 'isposinf', 'isreal', 'isrealobj', 'isscalar', 'issctype', 'issubclass_', 'issubdtype', 'issubsctype', 'iterable', 'ix_', 'kaiser', 'kron', 'ldexp', 'left_shift', 'less', 'less_equal', 'lexsort', 'lib', 'linalg', 'linspace', 'little_endian', 'load', 'loads', 'loadtxt', 'log', 'log10', 'log1p', 'log2', 'logaddexp', 'logaddexp2', 'logical_and', 'logical_not', 'logical_or', 'logical_xor', 'logspace', 'long', 'longcomplex', 'longdouble', 'longfloat', 'longlong', 'lookfor', 'ma', 'mafromtxt', 'mask_indices', 'mat', 'math', 'matrix', 'matrixlib', 'max', 'maximum', 'maximum_sctype', 'may_share_memory', 'mean', 'median', 'memmap', 'meshgrid', 'mgrid', 'min', 'min_scalar_type', 'minimum', 'mintypecode', 'mirr', 'mod', 'modf', 'msort', 'multiply', 'nan', 'nan_to_num', 'nanargmax', 'nanargmin', 'nanmax', 'nanmean', 'nanmin', 'nanstd', 'nansum', 'nanvar', 'nbytes', 'ndarray', 'ndenumerate', 'ndfromtxt', 'ndim', 'ndindex', 'nditer', 'negative', 'nested_iters', 'newaxis', 'newbuffer', 'nextafter', 'nonzero', 'not_equal', 'nper', 'npv', 'number', 'obj2sctype', 'object', 'object0', 'object_', 'ogrid', 'ones', 'ones_like', 'outer', 'packbits', 'pad', 'partition', 'percentile', 'pi', 'piecewise', 'pkgload', 'place', 'pmt', 'poly', 'poly1d', 'polyadd', 'polyder', 'polydiv', 'polyfit', 'polyint', 'polymul', 'polynomial', 'polysub', 'polyval', 'power', 'ppmt', 'print_function', 'prod', 'product', 'promote_types', 'ptp', 'put', 'putmask', 'pv', 'r_', 'rad2deg', 'radians', 'random', 'rank', 'rate', 'ravel', 'ravel_multi_index', 'real', 'real_if_close', 'rec', 'recarray', 'recfromcsv', 'recfromtxt', 'reciprocal', 'record', 'remainder', 'repeat', 'require', 'reshape', 'resize', 'restoredot', 'result_type', 'right_shift', 'rint', 'roll', 'rollaxis', 'roots', 'rot90', 'round', 'round_', 'row_stack', 's_', 'safe_eval', 'save', 'savetxt', 'savez', 'savez_compressed', 'sctype2char', 'sctypeDict', 'sctypeNA', 'sctypes', 'searchsorted', 'select', 'set_numeric_ops', 'set_printoptions', 'set_string_function', 'setbufsize', 'setdiff1d', 'seterr', 'seterrcall', 'seterrobj', 'setxor1d', 'shape', 'short', 'show_config', 'sign', 'signbit', 'signedinteger', 'sin', 'sinc', 'single', 'singlecomplex', 'sinh', 'size', 'sometrue', 'sort', 'sort_complex', 'source', 'spacing', 'split', 'sqrt', 'square', 'squeeze', 'std', 'str', 'str_', 'string0', 'string_', 'subtract', 'sum', 'swapaxes', 'sys', 'take', 'tan', 'tanh', 'tensordot', 'test', 'testing', 'tile', 'timedelta64', 'trace', 'transpose', 'trapz', 'tri', 'tril', 'tril_indices', 'tril_indices_from', 'trim_zeros', 'triu', 'triu_indices', 'triu_indices_from', 'true_divide', 'trunc', 'typeDict', 'typeNA', 'typecodes', 'typename', 'ubyte', 'ufunc', 'uint', 'uint0', 'uint16', 'uint32', 'uint64', 'uint8', 'uintc', 'uintp', 'ulonglong', 'unicode', 'unicode0', 'unicode_', 'union1d', 'unique', 'unpackbits', 'unravel_index', 'unsignedinteger', 'unwrap', 'ushort', 'vander', 'var', 'vdot', 'vectorize', 'version', 'void', 'void0', 'vsplit', 'vstack', 'warnings', 'where', 'who', 'zeros', 'zeros_like']
/System/Library/Frameworks/Python.framework/Versions/2.7/Extras/lib/python/numpy/__init__.pyc
```


## from {#from}

import는 package나 module에 있는 것들을 모두 객체 생성한다. 즉 import
numpy라고 하면 numpy라는 객체가 생성되고 그 내부에는 수많은 객체도
생성이된다. 이것은 memory낭비다. 그래서 from을 사용한다. from의
사용방법은 다음과 같다.

```text
from [module] import [변수,클래스,함수]
```

module에 있는 모든 객체를 생성하지 않고, 일부만 객체를 생성해서
사용한다. from을 사용하면, module을 객체로 만드는게 아니다. 따라서
import로 만들어지는 객체를 그대로 code내에서 사용할 수 있다. 예를들면,
pi,sqrt method를 그대로 사용할 수 있다.

```python
from math import pi,sqrt
pi
sqrt(3.0)
```
