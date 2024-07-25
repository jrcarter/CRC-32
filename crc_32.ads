-- CRC-32: Cyclic Redundancy Check to verify data integrity (ISO 3309)
-- Copyright (C) by Pragmada Software Engineering
-- Released under the terms of the BSD 3-Clause license; see https://opensource.org/licenses

-- Derived from Zip.CRC_Crypto by Gautier de Montmollin, which has the following license:
--  Copyright (c) 1999 .. 2024 Gautier de Montmollin
--  SWITZERLAND

--  Permission is hereby granted, free of charge, to any person obtaining a copy
--  of this software and associated documentation files (the "Software"), to deal
--  in the Software without restriction, including without limitation the rights
--  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
--  copies of the Software, and to permit persons to whom the Software is
--  furnished to do so, subject to the following conditions:

--  The above copyright notice and this permission notice shall be included in
--  all copies or substantial portions of the Software.

--  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
--  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
--  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
--  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
--  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
--  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
--  THE SOFTWARE.

--  NB: this is the MIT License, as found on the site
--  http://www.opensource.org/licenses/mit-license.php

-- Because of this derivation, the code may not adhere to the PragmAda Coding Standard

with Interfaces;

package CRC_32 is
   type CRC_Info is private;

   procedure Reset (CRC : in out CRC_Info) with Inline;
   -- Resets CRC to its default initial value

   subtype Byte_Value is Interfaces.Unsigned_8;

   procedure Update (CRC : in out CRC_Info; Input : in Byte_Value) with Inline;
   -- CRC update for a single byte

   type Byte_List is array (Positive range <>) of Byte_Value;

   procedure Update (CRC : in out CRC_Info; List : in Byte_List) with Inline;
   -- CRC update for a sequence of bytes

   function Final (CRC : in CRC_Info) return Interfaces.Unsigned_32 with Inline;
   -- Final CRC value after all updates
private -- CRC_32
   Default : constant := 16#FFFF_FFFF#;

   type CRC_Info is record
      Value : Interfaces.Unsigned_32 := Default;
   end record;

   use Interfaces;

   function Final (CRC : CRC_Info) return Interfaces.Unsigned_32 is
      (not CRC.Value);
end CRC_32;
