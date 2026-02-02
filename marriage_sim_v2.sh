#!/bin/bash

# =============================================
# social_marriage_simulator.sh - نسخه پیشرفته
# شبیه‌ساز شرایط ازدواج همسایه‌ای با قابلیت‌های بیشتر
# =============================================

# تنظیمات اولیه
BOY_NAME="پسر همسایه"
GIRL_NAME="دختر همسایه"
FAMILY_THRESHOLD=85  # حداقل امتیاز مالی مورد نیاز خانواده
CURRENT_FINANCIAL_SCORE=35
DELAY_YEARS=8
CURRENT_AGE=26
EMOTIONAL_NEED_LEVEL=95
RELATIONSHIP_QUALITY=75  # کیفیت رابطه عاطفی (0-100)
FAMILY_PRESSURE_LEVEL=60  # فشار اجتماعی خانواده (0-100)

# تنظیمات پیشرفته
INFLATION_RATE=5  # درصد تورم سالانه (کاهش قدرت خرید)
SOCIAL_EXPECTATIONS=70  # انتظارات اجتماعی (0-100)
ALTERNATIVE_OPTIONS=0  # گزینه‌های جایگزین برای دختر

# رنگ‌ها
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# تابع برای نمایش هدر
show_header() {
    clear
    echo -e "${CYAN}╔══════════════════════════════════════════════════════╗${NC}"
    echo -e "${YELLOW}║         شبیه‌ساز پیشرفته ازدواج همسایه‌ای           ║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# تابع برای نمایش وضعیت
show_status() {
    echo -e "${WHITE}┌──────────────────────────────────────────────────────┐${NC}"
    echo -e "${WHITE}│                    📊 وضعیت فعلی                    │${NC}"
    echo -e "${WHITE}├──────────────────────────────────────────────────────┤${NC}"
    echo -e "${WHITE}│  👤 نام پسر: $BOY_NAME${NC}"
    echo -e "${WHITE}│  🎂 سن فعلی: ${CURRENT_AGE} سال${NC}"
    echo -e "${WHITE}│  💰 امتیاز مالی: ${CURRENT_FINANCIAL_SCORE}/100${NC}"
    echo -e "${WHITE}│  💝 نیاز عاطفی: ${EMOTIONAL_NEED_LEVEL}/100${NC}"
    echo -e "${WHITE}│  🤝 کیفیت رابطه: ${RELATIONSHIP_QUALITY}/100${NC}"
    echo -e "${WHITE}│  🎯 حداقل مورد نیاز خانواده: ${FAMILY_THRESHOLD}/100${NC}"
    echo -e "${WHITE}└──────────────────────────────────────────────────────┘${NC}"
    echo ""
}

# تابع برای شبیه‌سازی تأثیر تورم
apply_inflation() {
    local score=$1
    local years=$2
    
    # تورم سالانه از ارزش مالی می‌کاهد
    local inflation_factor=$((100 - (INFLATION_RATE * years)))
    if [ $inflation_factor -lt 50 ]; then
        inflation_factor=50
    fi
    
    local adjusted_score=$((score * inflation_factor / 100))
    echo $adjusted_score
}

# تابع برای شبیه‌سازی فشار اجتماعی
simulate_social_pressure() {
    local years_waited=$1
    local current_age=$2
    
    # فشار اجتماعی با افزایش سن بیشتر می‌شود
    local age_pressure=0
    if [ $current_age -gt 30 ]; then
        age_pressure=$(((current_age - 30) * 5))
    fi
    
    # فشار ناشی از سال‌های انتظار
    local wait_pressure=$((years_waited * 8))
    
    local total_pressure=$((FAMILY_PRESSURE_LEVEL + age_pressure + wait_pressure))
    
    if [ $total_pressure -gt 100 ]; then
        total_pressure=100
    fi
    
    echo $total_pressure
}

# تابع برای شبیه‌سازی گزینه‌های جایگزین دختر
simulate_alternatives() {
    local girl_age=$1
    local years_waited=$2
    
    # با گذشت زمان، گزینه‌های جایگزین برای دختر افزایش می‌یابد
    local chance=$((RANDOM % 100))
    
    if [ $girl_age -gt 28 ]; then
        # کاهش گزینه‌ها با افزایش سن
        ALTERNATIVE_OPTIONS=$((ALTERNATIVE_OPTIONS - 10))
    else
        # افزایش طبیعی گزینه‌ها با گذشت زمان
        ALTERNATIVE_OPTIONS=$((ALTERNATIVE_OPTIONS + (years_waited * 5) + (RANDOM % 20)))
    fi
    
    if [ $ALTERNATIVE_OPTIONS -lt 0 ]; then
        ALTERNATIVE_OPTIONS=0
    elif [ $ALTERNATIVE_OPTIONS -gt 100 ]; then
        ALTERNATIVE_OPTIONS=100
    fi
    
    # شانس ملاقات با گزینه بهتر
    if [ $chance -lt $ALTERNATIVE_OPTIONS ] && [ $ALTERNATIVE_OPTIONS -gt 30 ]; then
        return 1  # گزینه بهتر پیدا شده
    fi
    
    return 0  # گزینه بهتر پیدا نشده
}

# تابع اصلی برای شبیه‌سازی سال‌های انتظار
simulate_waiting_years() {
    local years=$1
    local current_financial=$2
    local current_emotional=$3
    local current_relationship=$4
    local current_age=$5
    
    echo ""
    echo -e "${PURPLE}⏳ شروع شبیه‌سازی ${years} سال انتظار و تلاش...${NC}"
    echo ""
    
    local years_waited=0
    local financial_score=$current_financial
    local emotional_need=$current_emotional
    local relationship_quality=$current_relationship
    
    for ((year=1; year<=years; year++)); do
        years_waited=$year
        current_age=$((current_age + 1))
        
        echo -e "${WHITE}┌───────────────── سال ${year} ─────────────────┐${NC}"
        
        # شبیه‌سازی اتفاقات تصادفی
        local random_event=$((RANDOM % 100))
        
        # افزایش مالی (با نوسان)
        local financial_increment=$((10 + (RANDOM % 15)))
        
        # اتفاقات مثبت یا منفی تصادفی
        if [ $random_event -lt 15 ]; then
            # اتفاق منفی (بیماری، بیکاری، etc.)
            echo -e "${RED}   ⚠ اتفاق منفی: کاهش درآمد موقت${NC}"
            financial_increment=$((financial_increment / 2))
            emotional_need=$((emotional_need - 15))
        elif [ $random_event -gt 85 ]; then
            # اتفاق مثبت (ترفیع، سرمایه‌گذاری موفق)
            echo -e "${GREEN}   🎉 اتفاق مثبت: فرصت شغلی بهتر${NC}"
            financial_increment=$((financial_increment * 2))
        fi
        
        financial_score=$((financial_score + financial_increment))
        
        # کاهش نیاز عاطفی با گذر زمان
        local emotional_decrease=$((8 + (RANDOM % 12)))
        emotional_need=$((emotional_need - emotional_decrease))
        
        # کاهش کیفیت رابطه به دلیل انتظار طولانی
        if [ $year -gt 3 ]; then
            local relationship_decrease=$((5 + (RANDOM % 10)))
            relationship_quality=$((relationship_quality - relationship_decrease))
        fi
        
        # اعمال تورم بر امتیاز مالی
        financial_score=$(apply_inflation $financial_score 1)
        
        # محدود کردن محدوده‌ها
        if [ $financial_score -gt 100 ]; then
            financial_score=100
        fi
        if [ $emotional_need -lt 10 ]; then
            emotional_need=10
        fi
        if [ $relationship_quality -lt 30 ]; then
            relationship_quality=30
        fi
        
        # محاسبه فشار اجتماعی
        local social_pressure=$(simulate_social_pressure $year $current_age)
        
        # نمایش وضعیت سال
        echo -e "${WHITE}   🎂 سن: ${current_age} سال${NC}"
        echo -e "${WHITE}   💰 مالی: ${financial_score}/100${NC}"
        echo -e "${WHITE}   💔 عاطفی: ${emotional_need}/100${NC}"
        echo -e "${WHITE}   🤝 رابطه: ${relationship_quality}/100${NC}"
        echo -e "${WHITE}   ⚖ فشار اجتماعی: ${social_pressure}/100${NC}"
        
        # بررسی گزینه‌های جایگزین برای دختر
        simulate_alternatives $((CURRENT_AGE + year - 2)) $year
        if [ $? -eq 1 ] && [ $year -gt 2 ]; then
            echo -e "${YELLOW}   💔 دختر گزینه بهتری پیدا کرد!${NC}"
            return 255  # کد خروج ویژه برای پایان رابطه
        fi
        
        echo -e "${WHITE}└────────────────────────────────────────────┘${NC}"
        
        # بررسی شرایط برای ازدواج در هر سال
        if [ $financial_score -ge $FAMILY_THRESHOLD ]; then
            echo ""
            echo -e "${GREEN}🎊 در سال ${year} شرایط مالی فراهم شد!${NC}"
            
            # اما آیا هنوز تمایل وجود دارد؟
            if [ $emotional_need -gt 50 ] && [ $relationship_quality -gt 60 ]; then
                return $year  # بازگرداندن تعداد سال‌های صبر شده
            else
                echo -e "${YELLOW}⚠ اما اشتیاق اولیه کاهش یافته است...${NC}"
            fi
        fi
        
        sleep 0.8
    done
    
    return $years  # تمام سال‌ها صبر شد
}

# تابع برای تحلیل نهایی
analyze_final_result() {
    local years_waited=$1
    local final_financial=$2
    local final_emotional=$3
    local final_relationship=$4
    local final_age=$5
    local exit_code=$6
    
    echo ""
    echo -e "${CYAN}══════════════════════════════════════════════════════${NC}"
    echo -e "${YELLOW}                   📈 تحلیل نهایی                   ${NC}"
    echo -e "${CYAN}══════════════════════════════════════════════════════${NC}"
    echo ""
    
    case $exit_code in
        255)
            echo -e "${RED}✖ نتیجه: رابطه پایان یافت${NC}"
            echo -e "   • دختر گزینه بهتری پیدا کرد"
            echo -e "   • ${years_waited} سال انتظار بیهوده"
            echo -e "   • سن نهایی: ${final_age} سال"
            echo -e "   • امتیاز مالی نهایی: ${final_financial}/100"
            ;;
        0)
            echo -e "${YELLOW}⚠ نتیجه: هنوز شرایط فراهم نیست${NC}"
            echo -e "   • ${years_waited} سال انتظار"
            echo -e "   • نیاز به صبر بیشتر"
            echo -e "   • خطر از دست رفتن فرصت‌ها"
            ;;
        *)
            if [ $final_financial -ge $FAMILY_THRESHOLD ]; then
                if [ $final_emotional -gt 60 ] && [ $final_relationship -gt 65 ]; then
                    echo -e "${GREEN}✅ نتیجه: ازدواج امکان‌پذیر است${NC}"
                    echo -e "   • پس از ${years_waited} سال انتظار"
                    echo -e "   • سن نهایی: ${final_age} سال"
                    echo -e "   • هزینه فرصت: ${years_waited} سال از بهترین سال‌های زندگی"
                else
                    echo -e "${YELLOW}⚠ نتیجه: ازدواج امکان‌پذیر اما بی‌اشتیاق${NC}"
                    echo -e "   • رابطه تبدیل به یک تعهد خشک شده"
                    echo -e "   • احساس обиاد از سال‌های سخت گذشته"
                    echo -e "   • خطر نارضایتی در زندگی مشترک"
                fi
            else
                echo -e "${RED}✖ نتیجه: هنوز شرایط مالی فراهم نیست${NC}"
                echo -e "   • ${years_waited} سال تلاش بی‌ثمر"
                echo -e "   • تورم از پیشرفت مالی سریع‌تر بوده"
                echo -e "   • چرخه فقر زمانی ادامه دارد"
            fi
            ;;
    esac
    
    echo ""
    echo -e "${BLUE}💡 بینش اجتماعی:${NC}"
    
    if [ $years_waited -ge 5 ]; then
        echo -e "«سیستم اجتماعی ما جوانان را مجبور می‌کند سال‌های طلایی"
        echo -e "زندگی خود را صرف انباشت ثروت کنند، غافل از اینکه"
        echo -e "عشق و همراهی‌ای که در جوانی معنا داشت،"
        echo -e "در میانسالی ممکن است فقط یک قرارداد سرد باشد.»"
    fi
    
    # محاسبه هزینه فرصت
    local opportunity_cost=$((years_waited * 10000))  # به واحد فرضی
    echo ""
    echo -e "${WHITE}💰 هزینه فرصت: ${opportunity_cost} واحد از بهترین سال‌های زندگی${NC}"
    
    # پیشنهاد جایگزین
    echo ""
    echo -e "${GREEN}🌟 راه‌حل‌های جایگزین:${NC}"
    echo "1. جست‌جوی خانواده‌ای با ارزش‌های انسانی‌تر"
    echo "2. مهاجرت به محیطی با نگاه بازتر"
    echo "3. تمرکز بر رشد فردی و پذیرش احتمال تنهایی"
    echo "4. ایجاد کسب‌وکار مشترک قبل از ازدواج"
}

# تابع منوی اصلی
main_menu() {
    while true; do
        show_header
        show_status
        
        echo -e "${WHITE}گزینه‌های اصلی:${NC}"
        echo "1) شروع شبیه‌سازی"
        echo "2) تغییر پارامترها"
        echo "3) مشاهده آمار اجتماعی"
        echo "4) خروج"
        echo ""
        echo -n "انتخاب شما [1-4]: "
        read main_choice
        
        case $main_choice in
            1)
                start_simulation
                ;;
            2)
                change_parameters
                ;;
            3)
                show_social_stats
                ;;
            4)
                echo ""
                echo -e "${CYAN}با آرزوی آینده‌ای بهتر برای همه جوانان...${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}❌ انتخاب نامعتبر${NC}"
                sleep 1
                ;;
        esac
    done
}

# تابع شروع شبیه‌سازی
start_simulation() {
    show_header
    echo -e "${BLUE}🎬 شروع شبیه‌سازی ازدواج همسایه‌ای${NC}"
    echo ""
    
    # شبیه‌سازی درخواست اولیه
    echo -e "${WHITE}📨 ارسال درخواست ازدواج به خانواده دختر...${NC}"
    sleep 1
    
    if [ $CURRENT_FINANCIAL_SCORE -lt $FAMILY_THRESHOLD ]; then
        echo -e "${RED}✖ پاسخ خانواده: منفی${NC}"
        echo -e "${YELLOW}«پسر عزیز، اول شغل و درآمدت رو سروسامان بده»${NC}"
        echo -e "${YELLOW}«بعداً صحبت می‌کنیم...»${NC}"
        echo ""
        
        # شروع سال‌های انتظار
        simulate_waiting_years $DELAY_YEARS $CURRENT_FINANCIAL_SCORE $EMOTIONAL_NEED_LEVEL $RELATIONSHIP_QUALITY $CURRENT_AGE
        local result=$?
        local final_age=$((CURRENT_AGE + DELAY_YEARS))
        
        # تحلیل نهایی
        analyze_final_result $DELAY_YEARS $CURRENT_FINANCIAL_SCORE $EMOTIONAL_NEED_LEVEL $RELATIONSHIP_QUALITY $final_age $result
        
    else
        echo -e "${GREEN}✅ پاسخ خانواده: مثبت${NC}"
        echo -e "${GREEN}«خوشحال می‌شیم با چنین پسر سخت‌کوشی وصلت کنیم»${NC}"
        echo ""
        echo -e "${CYAN}🎉 ازدواج بدون انتظار طولانی محقق شد!${NC}"
    fi
    
    echo ""
    read -p "برای ادامه Enter بزنید..."
}

# تابع تغییر پارامترها
change_parameters() {
    show_header
    echo -e "${YELLOW}⚙ تنظیم پارامترهای شبیه‌سازی${NC}"
    echo ""
    
    echo -n "حداقل امتیاز مالی مورد نیاز خانواده [${FAMILY_THRESHOLD}]: "
    read new_threshold
    [ ! -z "$new_threshold" ] && FAMILY_THRESHOLD=$new_threshold
    
    echo -n "امتیاز مالی فعلی پسر [${CURRENT_FINANCIAL_SCORE}]: "
    read new_score
    [ ! -z "$new_score" ] && CURRENT_FINANCIAL_SCORE=$new_score
    
    echo -n "سن فعلی پسر [${CURRENT_AGE}]: "
    read new_age
    [ ! -z "$new_age" ] && CURRENT_AGE=$new_age
    
    echo -n "سال‌های انتظار [${DELAY_YEARS}]: "
    read new_delay
    [ ! -z "$new_delay" ] && DELAY_YEARS=$new_delay
    
    echo -n "نرخ تورم سالانه (درصد) [${INFLATION_RATE}]: "
    read new_inflation
    [ ! -z "$new_inflation" ] && INFLATION_RATE=$new_inflation
    
    echo -e "${GREEN}✅ پارامترها به روز شدند${NC}"
    sleep 1
}

# تابع نمایش آمار اجتماعی
show_social_stats() {
    show_header
    echo -e "${PURPLE}📊 آمار اجتماعی ازدواج در ایران${NC}"
    echo ""
    
    echo -e "${WHITE}بر اساس گزارش‌های مرکز آمار ایران:${NC}"
    echo "• متوسط سن ازدواج پسران: ۲۹ سال"
    echo "• متوسط سن ازدواج دختران: ۲۴ سال"
    echo "• نرخ بیکاری جوانان: حدود ۲۵٪"
    echo "• درصد ازدواج‌های فامیلی: ۳۸٪"
    echo "• متوسط هزینه جهیزیه و مهریه: معادل ۵۰۰ سکه"
    echo "• رشد قیمت مسکن در ۵ سال گذشته: ۴۰۰٪"
    echo ""
    
    echo -e "${YELLOW}📈 تأثیرات اقتصادی:${NC}"
    echo "• ۶۰٪ جوانان معتقدند مشکل اصلی ازدواج، مسکن است"
    echo "• ۴۵٪ ازدواج‌ها با کمک مالی والدین صورت می‌گیرد"
    echo "• زمان متوسط برای پس‌انداز مهریه: ۸ سال"
    echo ""
    
    echo -e "${RED}⚠ پیامدهای اجتماعی:${NC}"
    echo "• افزایش ۳۰٪ی طلاق در ۵ سال اول زندگی"
    echo "• کاهش ۴۰٪ی نرخ ازدواج در یک دهه گذشته"
    echo "• افزایش زندگی مجردی به ۱۵٪ جمعیت جوان"
    
    echo ""
    read -p "برای ادامه Enter بزنید..."
}

# ==================== شروع برنامه ====================
show_header
echo -e "${CYAN}خوش آمدید به شبیه‌ساز پیشرفته شرایط ازدواج${NC}"
echo -e "${YELLOW}این برنامه بر اساس تحلیل شما از شرایط اجتماعی طراحی شده${NC}"
echo ""
echo -e "🎯 هدف: شبیه‌سازی تأثیر شرط‌های مالی بر ازدواج همسایه‌ای"
echo -e "📅 سال شبیه‌سازی: ۱۴۰۳"
echo ""
read -p "برای شروع Enter بزنید..."

# اجرای منوی اصلی
main_menu