#!/data/data/com.termux/files/usr/bin/bash

# Barname Password Generator ba Manteghe Shenakht
# Shenakht: Awareness | Manteghe: Logic

clear
echo "██████╗ █████╗ ██████╗ ███████╗██╗  ██╗ ██████╗ ██████╗ ██████╗"
echo "██╔══██╗██╔══██╗██╔══██╗██╔════╝██║  ██║██╔═══██╗██╔══██╗██╔══██╗"
echo "██████╔╝███████║██████╔╝███████╗███████║██║   ██║██████╔╝██║  ██║"
echo "██╔═══╝ ██╔══██║██╔══██╗╚════██║██╔══██║██║   ██║██╔══██╗██║  ██║"
echo "██║     ██║  ██║██║  ██║███████║██║  ██║╚██████╔╝██║  ██║██████╔╝"
echo "╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═════╝"
echo "              Generator e Mantaghi | Shenakht e Password"
echo "================================================================"
echo ""
# Mabda: Har password bayad yek manteghe daroun dashte bashad
# Shenakht: User bayad az manteghe password khod agah bashad

echo "[MARHALE 1] - SHENAKHT e MANTEGHE"
echo "--------------------------------"
echo "Password mantaghi passwordi ast ke:"
echo "1. Baraye shoma ma'ni darad"
echo "2. Be soorate manteghi sakhte shode"
echo "3. Yad dashtan an sadeh bashad"
echo "4. Hack kardan an sakht bashad"
echo ""
echo "[?] Name shoma chist? (be englisi): "
read user_name
echo ""
echo "[MARHALE 2] - ENTEXHAB MANTEGHE ASLI"
echo "-----------------------------------"
echo "Yeki az manteghe haye zir ra entekhab konid:"
echo "1. Tarikh (birthday, anniversary, etc.)"
echo "2. Jomle (favorite quote, song lyric)"
echo "3. Name (people, places, things)"
echo "4. Algorithm (pattern, sequence)"
echo "5. Dastur (command, instruction)"
echo ""
echo "[?] Raqam manteghe khod ra vared konid (1-5): "
read logic_type
echo ""
echo "[MARHALE 3] - SAKHTARE MANTAGHI"
echo "-------------------------------"

case $logic_type in
    1) # Tarikh
        echo "[MANTEGHE: TARIKH]"
        echo "[?] Tarikh e mohem (DDMMYYYY): "
        read important_date
        echo "[?] Kalame ezafe: "
        read extra_word
        base_password="${important_date}${extra_word}"
        ;;
    2) # Jomle
        echo "[MANTEGHE: JOMLE]"
        echo "[?] Avalin harf e har kalame yek jomle (masalan: ILY = I Love You): "
        read acronym
        echo "[?] Adad e ezafe: "
        read extra_number
        base_password="${acronym}${extra_number}"
        ;;
    3) # Name
        echo "[MANTEGHE: NAME]"
        echo "[?] Name e avali: "
        read name1
        echo "[?] Name e dovom: "
        read name2
        echo "[?] Symbol beyneshun (!@#$%): "
        read symbol
        base_password="${name1}${symbol}${name2}"
        ;;
    4) # Algorithm
        echo "[MANTEGHE: ALGORITHM]"
        echo "[?] Pattern ra vared konid (masalan: 13579): "
        read pattern
        echo "[?] Tedad tekrar: "
        read repeat_count
        base_password=""
        for i in $(seq 1 $repeat_count); do
            base_password="${base_password}${pattern}"
        done
        ;;
    5) # Dastur
        echo "[MANTEGHE: DASTUR]"
        echo "[?] Dastur asli (masalan: RUN): "
        read command_word
        echo "[?] Parameter: "
        read parameter
        echo "[?] Operator (+, -, =): "
        read operator
        base_password="${command_word}${operator}${parameter}"
        ;;
    *)
        echo "Manteghe na motabar!"
        exit 1
        ;;
esac

echo ""
echo "[MARHALE 4] - TRANSFORM e MANTAGHI"
echo "----------------------------------"
echo "Transform haye zir ra baraye ghove asli password entekhab konid:"
echo "1. Reverse kardan (123 → 321)"
echo "2. Doubling (abc → aabbcc)"
echo "3. Pattern (A1B2C3)"
echo "4. Rotation (ABC → BCD)"
echo "5. Hash simple"
echo ""
echo "[?] Transform ra entexhab konid (1-5): "
read transform_type

echo ""
echo "[?] Password asli shoma: $base_password"
echo "[?] Tool e nahayi password? (8-32): "
read final_length

# Apply transform
case $transform_type in
    1) # Reverse
        transformed=$(echo "$base_password" | rev)
        ;;
    2) # Doubling
        transformed=""
        for (( i=0; i<${#base_password}; i++ )); do
            char="${base_password:$i:1}"
            transformed="${transformed}${char}${char}"
        done
        ;;
    3) # Pattern
        transformed=""
        count=1
        for (( i=0; i<${#base_password}; i++ )); do
            char="${base_password:$i:1}"
            transformed="${transformed}${char}${count}"
            count=$(( (count % 9) + 1 ))
        done
        ;;
    4) # Rotation
        transformed=""
        for (( i=0; i<${#base_password}; i++ )); do
            char="${base_password:$i:1}"
            if [[ "$char" =~ [A-Za-z] ]]; then
                if [[ "$char" =~ [A-Ya-y] ]]; then
                    next_char=$(echo "$char" | tr 'A-Ya-y' 'B-Zb-z')
                else
                    next_char=$(echo "$char" | tr 'Zz' 'Aa')
                fi
                transformed="${transformed}${next_char}"
            else
                transformed="${transformed}${char}"
            fi
        done
        ;;
    5) # Hash simple
        transformed=$(echo -n "$base_password" | md5sum | cut -c1-16)
        ;;
    *)
        transformed="$base_password"
        ;;
esac

echo ""
echo "[MARHALE 5] - COMPLEXITY e MANTAGHI"
echo "-----------------------------------"
echo "Level e complexity ra entexhab konid:"
echo "1. Sadeh (faghat manteghe)"
echo "2. Motavaset (manteghe + symbol)"
echo "3. Pishrafte (manteghe + algorithm)"
echo "4. Elteghab (dynamic manteghe)"
echo ""
echo "[?] Level complexity (1-4): "
read complexity_level

final_password=""

case $complexity_level in
    1) # Sadeh
        final_password="${transformed}"
        ;;
    2) # Motavaset
        symbols="!@#$%^&*"
        symbol="${symbols:$((RANDOM % ${#symbols})):1}"
        if [ $((RANDOM % 2)) -eq 0 ]; then
            final_password="${symbol}${transformed}"
        else
            final_password="${transformed}${symbol}"
        fi
        ;;
    3) # Pishrafte
        # Algorithm e pishrafte: manteghe + name + tarikh
        name_part=$(echo "$user_name" | cut -c1-3)
        date_part=$(date +%m%d | rev)
        final_password="${transformed:0:${#transformed}/2}${name_part}${date_part}${transformed:${#transformed}/2}"
        ;;
    4) # Elteghab
        # Dynamic manteghe: har bar yek password e jadid ba manteghe yeksan
        dynamic_salt=$(date +%s | rev | cut -c1-4)
        dynamic_pattern=""
        for (( i=0; i<${#transformed}; i++ )); do
            char="${transformed:$i:1}"
            if [ $((i % 2)) -eq 0 ]; then
                dynamic_pattern="${dynamic_pattern}${char}${dynamic_salt:$((i % ${#dynamic_salt})):1}"
            else
                dynamic_pattern="${dynamic_pattern}${char}"
            fi
        done
        final_password="$dynamic_pattern"
        ;;
esac
echo ""
echo "[MARHALE 6] - SHENAKHT va AGAHI"
echo "-------------------------------"
echo "AKNUN SHOMA SHENAKHT DARID:"
echo "============================"
echo ""
echo "Password shoma dar 6 marhale sakhte shod:"
echo "1. Manteghe Asli: [$base_password]"
echo "2. Transform: [$transformed]"
echo "3. Complexity: Level $complexity_level"
echo ""
echo "[MANTEGHE SHOMA]:"
echo "-----------------"
echo "$final_password"
echo "-----------------"
echo ""
echo "[TIPS BARAYE YAD DASHTAN]:"
echo "1. Manteghe asli: $base_password"
echo "2. Transform type: $transform_type"
echo "3. Complexity: $complexity_level"
echo ""
echo "[BARAYE BAZ NESHANI]:"
echo "Zemn password:"
echo "- Manteghe: $base_password"
echo "- Name: $user_name"
echo "- Transform: $transform_type"
echo ""
echo "Password komak:"
echo "- Aval: $(echo "$final_password" | cut -c1-4)"
echo "- Akhar: $(echo "$final_password" | rev | cut -c1-4 | rev)"
echo "- Tool: ${#final_password}"
echo ""
echo "[MARHALE 7] - GENERATOR haye MAKHSOOS"
echo "-------------------------------------"
echo "Generator haye makhsoos baraye password haye mantaghi:"

# 1. Password ba manteghe tarikhi
echo ""
echo "1. TARIKHI Generator:"
for i in {1..3}; do
    date_code=$(date -d "$i days ago" +%d%m)
    hist_pass="${date_code}${user_name:0:2}!"
    echo "   $i. $hist_pass (tarikh: $date_code)"
done

# 2. Password ba manteghe shaxsi
echo ""
echo "2. SHAXSI Generator:"
echo "   Name: ${user_name}123!"
echo "   Reverse: $(echo "$user_name" | rev)456@"
echo "   Mixed: ${user_name:0:1}${user_name: -1}789#"

# 3. Password ba manteghe algorithmi
echo ""
echo "3. ALGORITHMI Generator:"
echo "   Pattern 135: 1${user_name:0:1}3${user_name:1:1}5${user_name:2:1}"
echo "   Binary: $(echo "$user_name" | od -An -t dC | tr -d ' ' | cut -c1-8)"
echo "   Sum: $(echo "$user_name" | tr -d '\n' | od -An -t dC | awk '{sum=0; for(i=1;i<=NF;i++) sum+=$i; print sum}')"
echo ""
echo "[MARHALE 8] - SHENAKHT e SECURITY"
echo "---------------------------------"
echo "CHERA IN PASSWORD MANTAGHI AST VA AMN?:"
echo ""

# Analiz e password
password="$final_password"
has_upper=$(echo "$password" | grep -q '[A-Z]' && echo "✓" || echo "✗")
has_lower=$(echo "$password" | grep -q '[a-z]' && echo "✓" || echo "✗")
has_digit=$(echo "$password" | grep -q '[0-9]' && echo "✓" || echo "✗")
has_special=$(echo "$password" | grep -q '[!@#$%^&*]' && echo "✓" || echo "✗")
length=${#password}

echo "Analiz e Password:"
echo "  Tool: $length character $([ $length -ge 12 ] && echo "✓" || echo "✗")"
echo "  Horouf bozorg: $has_upper"
echo "  Horouf kuchak: $has_lower"
echo "  Adad: $has_digit"
echo "  Symbol: $has_special"
echo ""
echo "[MANTEGHE AMNIATI]:"
echo "1. Password shoma dar 8 marhale sakhte shod"
echo "2. Manteghe shoma: $base_password"
echo "3. Transform: Type $transform_type"
echo "4. Har kas ke in 3 ra bedanad, password ra midanad"
echo "5. FA GHAT SHOMA IN 3 RA MIDA NID"
echo ""
echo "[SARMAGHZ e MANTEGHE]:"
echo "Manteghe shoma haman '$base_password' ast"
echo "Transform shoma: $transform_type"
echo "Ba in etelaat, mitavanid dar har system jadid"
echo "haman password ra dobare besazid!"
echo ""
echo "[MARHALE 9] - TEST e SHENAKHT"
echo "-----------------------------"
echo "TEST KONID KE MANTEGHE RA YAD DARID:"
echo ""

sleep 2

echo "[SOAL 1] Manteghe asli shoma chist?"
read user_answer1
if [ "$user_answer1" = "$base_password" ]; then
    echo "✓ DOROST! Manteghe asli: $base_password"
else
    echo "✗ Eshtebah! Manteghe asli: $base_password"
fi

echo ""
echo "[SOAL 2] Transform type shoma chand bood?"
read user_answer2
if [ "$user_answer2" = "$transform_type" ]; then
    echo "✓ DOROST! Transform type: $transform_type"
else
    echo "✗ Eshtebah! Transform type: $transform_type"
fi

echo ""
echo "[SOAL 3] Avalin 3 horouf password?"
read user_answer3
first_three=$(echo "$final_password" | cut -c1-3)
if [ "$user_answer3" = "$first_three" ]; then
    echo "✓ DOROST! Avalin 3 horouf: $first_three"
else
    echo "✗ Eshtebah! Avalin 3 horouf: $first_three"
fi

echo ""
echo "[PAYAN e TEST]:"
echo "Agar 2 az 3 soal ra javab dadid, SHENAKHT DARID!"
echo "Shoma manteghe password khod ra mishnasid."
echo ""
echo "================================================================"
echo "[PAYAN e GENERATOR e MANTAGHI]"
echo "================================================================"
echo ""
echo "[SHENASE MANTAGHI e SHOMA]:"
echo "==========================="
echo "Name: $user_name"
echo "Manteghe Type: $logic_type"
echo "Manteghe Asli: $base_password"
echo "Transform: $transform_type"
echo "Complexity: $complexity_level"
echo "Password Nahayi: $final_password"
echo "Tool: ${#final_password} character"
echo ""
echo "[SARMAGHZ e MANTEGHE]:"
echo "Har gozine dar in barname yek manteghe dasht"
echo "Shoma manteghe khod ra entexhab kardid"
echo "Password shoma faghat az manteghe shoma neshate gerefte"
echo "IN HAMAN SHENAKHT AST"
echo ""
echo "Ba tashakor az estefade az Generator e Mantaghi"
echo "Password shoma: Yek manteghe, yek shenakht"
echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║  SHENAKHT = DARKHEST + ENTEXHAB + TRANSFORM      ║"
echo "╚══════════════════════════════════════════════════╝"

