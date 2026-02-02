#!/bin/bash

# =============================================
# social_marriage_simulator.sh
# شبیه‌ساز شرایط ازدواج همسایه‌ای
# بر اساس تحلیل ارائه شده
# =============================================

# تنظیمات اولیه
BOY_NAME="پسر همسایه"
GIRL_NAME="دختر همسایه"
FAMILY_THRESHOLD=80  # حداقل امتیاز مالی مورد نیاز خانواده (از 100)
CURRENT_FINANCIAL_SCORE=30
DELAY_YEARS=7
CURRENT_AGE=25
EMOTIONAL_NEED_LEVEL=90

# رنگ‌ها برای نمایش بهتر
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

clear
echo -e "${CYAN}=============================================${NC}"
echo -e "${YELLOW} شبیه‌ساز شرایط ازدواج همسایه‌ای ${NC}"
echo -e "${CYAN}=============================================${NC}"
echo ""
echo -e "وضعیت اولیه:"
echo -e "  نام پسر: ${BOY_NAME}"
echo -e "  سن فعلی: ${CURRENT_AGE} سال"
echo -e "  امتیاز مالی فعلی: ${CURRENT_FINANCIAL_SCORE}/100"
echo -e "  حداقل مورد نیاز خانواده: ${FAMILY_THRESHOLD}/100"
echo -e "  سطح نیاز عاطفی فعلی: ${EMOTIONAL_NEED_LEVEL}/100"
echo ""

# تابع برای بررسی پاسخ خانواده
check_family_response() {
    local financial_score=$1
    local emotional_need=$2
    
    echo -e "${BLUE}[ارزیابی خانواده دختر]${NC}"
    echo -e "  امتیاز مالی شما: ${financial_score}/100"
    
    if [ $financial_score -ge $FAMILY_THRESHOLD ]; then
        echo -e "  ${GREEN}✅ خانواده پاسخ مثبت می‌دهد!${NC}"
        return 0  # موفق
    else
        echo -e "  ${RED}✖ خانواده پاسخ منفی می‌دهد${NC}"
        echo -e "  ${YELLOW}↳ دلیل: «هنوز توانایی مالی کافی ندارید»${NC}"
        return 1  # ناموفق
    fi
}

# تابع برای شبیه‌سازی گذر زمان و تلاش
simulate_years_of_effort() {
    local years=$1
    local current_score=$2
    
    echo ""
    echo -e "${PURPLE}[شبیه‌سازی ${years} سال تلاش و انتظار]${NC}"
    
    for ((year=1; year<=years; year++)); do
        AGE=$((CURRENT_AGE + year))
        
        # افزایش تدریجی امتیاز مالی
        FINANCIAL_INCREMENT=$((RANDOM % 15 + 5))
        current_score=$((current_score + FINANCIAL_INCREMENT))
        
        # کاهش تدریجی نیاز عاطفی
        EMOTIONAL_DECREASE=$((RANDOM % 20 + 5))
        EMOTIONAL_NEED_LEVEL=$((EMOTIONAL_NEED_LEVEL - EMOTIONAL_DECREASE))
        
        # محدود کردن محدوده‌ها
        if [ $current_score -gt 100 ]; then
            current_score=100
        fi
        
        if [ $EMOTIONAL_NEED_LEVEL -lt 10 ]; then
            EMOTIONAL_NEED_LEVEL=10
        fi
        
        echo -e "  سال ${year}: سن=${AGE} | مالی=${current_score}/100 | عاطفی=${EMOTIONAL_NEED_LEVEL}/100"
        
        # بررسی پاسخ خانواده در هر سال
        check_family_response $current_score $EMOTIONAL_NEED_LEVEL
        if [ $? -eq 0 ]; then
            echo ""
            echo -e "${GREEN}🎉 در سال ${year}ام موافقت شد!${NC}"
            return $current_score
        fi
        
        sleep 0.5  # تأثیر نمایشی
    done
    
    return $current_score
}

# ==================== شروع شبیه‌سازی ====================

echo -e "${RED}🔔 درخواست اولیه برای ازدواج${NC}"
check_family_response $CURRENT_FINANCIAL_SCORE $EMOTIONAL_NEED_LEVEL

if [ $? -eq 1 ]; then
    echo ""
    echo -e "${YELLOW}⚠ خانواده می‌گوید: «باید صبر کنید تا شرایط مالی بهتر شود»${NC}"
    
    # شبیه‌سازی سال‌های انتظار
    simulate_years_of_effort $DELAY_YEARS $CURRENT_FINANCIAL_SCORE
    FINAL_SCORE=$?
    
    echo ""
    echo -e "${CYAN}=============================================${NC}"
    echo -e "${YELLOW}📊 نتیجه نهایی شبیه‌سازی${NC}"
    echo -e "${CYAN}=============================================${NC}"
    echo ""
    
    FINAL_AGE=$((CURRENT_AGE + DELAY_YEARS))
    echo -e "  سن نهایی: ${FINAL_AGE} سال"
    echo -e "  امتیاز مالی نهایی: ${FINAL_SCORE}/100"
    echo -e "  سطح نیاز عاطفی نهایی: ${EMOTIONAL_NEED_LEVEL}/100"
    echo ""
    
    # تحلیل نهایی
    if [ $FINAL_SCORE -ge $FAMILY_THRESHOLD ] && [ $EMOTIONAL_NEED_LEVEL -gt 50 ]; then
        echo -e "${GREEN}✅ ازدواج امکان‌پذیر است، اما:${NC}"
        echo -e "   • سال‌های طلایی از دست رفته"
        echo -e "   • فشار روانی قابل توجه"
    elif [ $FINAL_SCORE -ge $FAMILY_THRESHOLD ] && [ $EMOTIONAL_NEED_LEVEL -le 50 ]; then
        echo -e "${YELLOW}⚠ ازدواج امکان‌پذیر است، اما:${NC}"
        echo -e "   • اشتیاق اولیه از بین رفته"
        echo -e "   • «وقتی نیاز داشتیم، کسی همراهمان نبود»"
    else
        echo -e "${RED}✖ هنوز شرایط مالی کافی نیست${NC}"
        echo -e "   • چرخه انتظار ادامه دارد..."
    fi
    
    echo ""
    echo -e "${BLUE}💭 تحلیل نهایی:${NC}"
    echo -e "«این سیستم، ازدواج را از یک انتخاب عاطفی به یک"
    echo -e "معامله اقتصادی تبدیل کرده است. زمانی که بیشترین"
    echo -e "نیاز به همراهی بود، شرط‌های سخت گذاشته شد،"
    echo -e "و اکنون که شاید شرایط فراهم باشد،"
    echo -e "آن اشتیاق اولیه ارزش خود را از دست داده است.»"
fi

echo ""
echo -e "${CYAN}=============================================${NC}"
echo -e "پایان شبیه‌سازی"
echo -e "${CYAN}=============================================${NC}"

# گزینه‌های اجرایی دیگر
echo ""
echo -e "${BLUE}گزینه‌های پیشرفته:${NC}"
echo "1. تغییر پارامترها و اجرای مجدد"
echo "2. خروج"
echo -n "انتخاب شما [1/2]: "
read choice

if [ "$choice" = "1" ]; then
    echo -n "حداقل مالی مورد نیاز خانواده [80]: "
    read new_threshold
    if [ ! -z "$new_threshold" ]; then
        FAMILY_THRESHOLD=$new_threshold
    fi
    echo -n "سال‌های انتظار [7]: "
    read new_delay
    if [ ! -z "$new_delay" ]; then
        DELAY_YEARS=$new_delay
    fi
    # اجرای مجدد
    exec "$0"
fi