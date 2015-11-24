# -*- coding: utf-8 -*-
# cython: profile=True

from __future__ import division

cimport mesh
from libc.stdlib cimport malloc, free
from zonemap cimport Zonemap


cdef class DifferentialMesh(mesh.Mesh):

  cdef double nearl

  cdef double farl

  cdef long num_sources

  cdef double source_rad

  cdef double *DX

  cdef double *DY

  cdef double *SX

  cdef double *SY

  cdef Zonemap source_zonemap

  ## FUNCTIONS

  cdef long __reject(self, double scale) nogil

  cdef long __attract(self, double scale) nogil

  cdef long __edge_vertex_force(self, long he1, long v1, double scale) nogil

  cdef long __triangle_force(self, double scale) nogil

  cdef long __merge_ragged_edge(self, long he1, long he3, long he4) nogil

  cdef long __find_nearby_sources(self) nogil

  cdef long __smooth_intensity(self, double alpha) nogil

  ## EXTERNAL

  cpdef long initialize_sources(self, list sources, double source_rad)

  cpdef long find_nearby_sources(self)

  cpdef long optimize_position(self, double step)

  cpdef long throw_seed_triangle(
    self,
    long he1,
    double h,
    double dx,
    double dy,
    double rad
  )

  cpdef long new_triangle_from_surface_edge(
    self,
    long he1,
    double h,
    double dx,
    double dy,
    double minimum_length=*,
    double maximum_length=*,
    long merge_ragged_edge=*
  )

  cpdef long smooth_intensity(self, double alpha)

