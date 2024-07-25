-- CRC-32: Cyclic Redundancy Check to verify data integrity (ISO 3309)
-- Copyright (C) by Pragmada Software Engineering
-- Released under the terms of the BSD 3-Clause license; see https://opensource.org/licenses

package body CRC_32 is
   type CRC_Table is array (Interfaces.Unsigned_32 range 0 .. 255) of Interfaces.Unsigned_32;

   Table : CRC_Table; -- Deferred constant initialized during elaboration

   procedure Update (Value : in out Unsigned_32; Input : in Byte_Value) with Inline;
   -- CRC update for a single byte

   procedure Reset (CRC : in out CRC_Info) is
      -- Empty
   begin -- Reset
      CRC.Value := Default;
   end Reset;

   procedure Update (Value : in out Unsigned_32; Input : in Byte_Value) is
      -- Empty
   begin -- Update
      Value := Table (16#FF# and (Value xor Unsigned_32 (Input) ) ) xor Shift_Right (Value, 8);
   end Update;

   procedure Update (CRC : in out CRC_Info; Input : in Byte_Value) is
      -- Empty
   begin -- Update
      Update (Value => CRC.Value, Input => Input);
   end Update;

   procedure Update (CRC : in out CRC_Info; List : in Byte_List) is
      -- Empty
   begin
      Update_All : for Byte of List loop
         Update (Value => CRC.Value, Input => Byte);
      end loop Update_All;
   end Update;

   Seed : constant := 16#EDB88320#;

   L : Interfaces.Unsigned_32;
begin -- CRC_32
   Fill : for I in Table'Range loop
      L := I;

      All_Bits : for Bit in 0 .. 7 loop
         if (L and 1) = 0 then
            L := Shift_Right (L, 1);
         else
            L := Shift_Right (L, 1) xor Seed;
         end if;
      end loop All_Bits;

      Table (I) := L;
   end loop Fill;
end CRC_32;
