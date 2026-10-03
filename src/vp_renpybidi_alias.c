#include <Python.h>
PyMODINIT_FUNC PyInit_bidi(void);
PyMODINIT_FUNC PyInit__renpybidi(void) { return PyInit_bidi(); }
