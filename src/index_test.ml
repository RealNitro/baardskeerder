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

open Index
open OUnit

let t_neigbours () = 
  let z = Loc ((7, [("j", 15); ("d", 14)]), []) in
  let nb = Index.indexz_neighbours z in
  OUnit.assert_equal (NL 14) nb

let t_suppress () = 
  let z = Loc ((7, [("j", 15); ("d", 14)]), []) in
  let nb = Index.indexz_neighbours z in
  match nb with 
    | NL 14 ->
      let index = Index.indexz_suppress L 17 z in
      Printf.printf "index = %s\n" (index2s index)
    | _ -> failwith "should be NL 14"

let t_suppress2 () = 
  let z = Loc ((7,["d", 8]),[]) in
  let nb = Index.indexz_neighbours z in
  match nb with 
    | NL 7 ->
      let index = Index.indexz_suppress L 17 z in
      Printf.printf "index = %s\n" (index2s index)
    | _ -> failwith "should be NL 7"

let t_balance() =
  let z = Loc ((7,["q", 22; "j", 21; "d", 14]),[]) in
  let z' = Index.indexz_balance z in
  match z' with
    | Loc ((_,l),r) -> let ls = List.length l in
		       let rs = List.length r in
		       OUnit.assert_equal ~printer:string_of_int ls 2;
		       OUnit.assert_equal ~printer:string_of_int rs 1
    | _ -> failwith "should be Loc"

let t_balance2 () =
  let z = Top (0,["d", 1; "j", 2; "q", 3]) in
  let z' = Index.indexz_balance z in
  match z' with
    | Loc ((_,l),r) -> let ls = List.length l in
		       let rs = List.length r in
		       OUnit.assert_equal ~printer:string_of_int ls 2;
		       OUnit.assert_equal ~printer:string_of_int rs 1
    | _ -> failwith "should be Loc"

let t_split () = 
  let lpos = 21
  and sep = "q"
  and rpos = 22
  and z = Loc ((7, [("j", 18); ("d", 14)]), [])
  in
  let left,sep', right = indexz_split lpos sep rpos z in
  OUnit.assert_equal ~printer:index2s (7, ["d",14]) left

let t_split2() = 
  let lpos = 21 
  and sep = "j"
  and rpos = 22 
  and z = Loc ((7, [("d", 18)]), [("q", 15)]) in
  let left,sep',right = indexz_split lpos sep rpos z in
  let printer = index2s in
  OUnit.assert_equal ~printer (7,["d",21]) left;
  OUnit.assert_equal ~printer (22,["q",15]) right

let t_replace () = 
  let z = Loc ((7, [("d", 14)]), [("m", 15)]) in
  let index = Index.indexz_replace 18 z in
  OUnit.assert_equal ~printer:index2s index (7,("d",18) :: ("m",15)::[])

let suite = 
  "Index" >:::[
    "neighbours" >:: t_neigbours;
    "suppress"   >:: t_suppress;
    "suppress2"  >:: t_suppress2;
    "balance"    >:: t_balance;
    "balance2"   >:: t_balance2;
    "split"      >:: t_split;
    "split2"     >:: t_split2;
    "replace"    >:: t_replace;
  ]
