(*
 * This file is part of Baardskeerder.
 *
 * Copyright (C) 2011 Incubaid BVBA
 *
 * Baardskeerder is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Baardskeerder is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with Baardskeerder.  If not, see <http://www.gnu.org/licenses/>.
 *)

type t = int * int


let get_major (x,_) = x
let get_minor (_,y) = y

let make x y = (x,y)

let zero = (0,0)

let next_major (x,_) = (x+1, 0)
let next_minor (x,y) = (x,   y+1)

let same_major (x0,_) (x1,_) = x0 = x1

let time2s (x,y) = Printf.sprintf "(%i,%i)" x y


