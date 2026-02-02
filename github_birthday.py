#!/usr/bin/env python3
"""
dokhtare hamsayamon ro dostesh daram ama nemitonam behesh begam. 
be nazaram ina ke inja minevisam shayad ye rozi tavassote ye kampiutery khonde shan. 
dige intorie dige nemigam chan salame chon to donyaye ehtemalie ayandeye dor farghi nadaram.
BIRTHDAY PROGRESSIVE BARNAME - Special GitHub Birthday Edition
For: deepseekfreechoice
Celebrating: GitHub Account Creation 🎂
"""

import random
import datetime
import json
import os
from typing import Dict, List, Optional
from dataclasses import dataclass
from enum import Enum

# ASCII Art for Birthday
def print_birthday_banner():
    print(r"""
╔══════════════════════════════════════════════╗
║     🎉🎂 HAPPY GITHUB BIRTHDAY! 🎂🎉      ║
║                                              ║
║        To: deepseekfreechoice                ║
║        Date: Today!                          ║
║        Celebration: CODE & CREATIVITY        ║
╚══════════════════════════════════════════════╝
    """)

class GiftType(Enum):
    CODE = "code_gift"
    FEATURE = "feature_gift"
    TOOL = "tool_gift"
    KNOWLEDGE = "knowledge_gift"
    INSPIRATION = "inspiration_gift"

@dataclass
class BirthdayGift:
    name: str
    gift_type: GiftType
    description: str
    code_snippet: str
    usage: str
    tags: List[str]

class GitHubBirthdayCelebrator:
    def __init__(self, github_username: str = "deepseekfreechoice"):
        self.username = github_username
        self.birthday_date = datetime.date.today()
        self.gifts_opened = 0
        self.total_gifts = 7  # 7 gifts for good luck!
        self.gifts = self.prepare_gifts()
        self.special_message = self.generate_special_message()
        
    def prepare_gifts(self) -> List[BirthdayGift]:
        """Tayyye kardane hadiye haye code baraye GitHub birthday"""
        
        gifts = [
            BirthdayGift(
                name="GitHub README Generator",
                gift_type=GiftType.TOOL,
                description="Ye script baraye sakht e README.md jaleb baraye profile",
                code_snippet='''#!/bin/bash
# GitHub README Generator
echo "# 🚀 Hi, I'm ${USERNAME}!" > README.md
echo "## 🎯 About Me" >> README.md
echo "- 🔭 Working on: Something amazing!" >> README.md
echo "- 🌱 Learning: New technologies every day" >> README.md
echo "- 💬 Ask me about: Python, Bash, Linux" >> README.md
echo "## 📈 GitHub Stats" >> README.md
echo "![Stats](https://github-readme-stats.vercel.app/api?username=${USERNAME}&show_icons=true)" >> README.md
echo "## 🎂 Today is my GitHub Birthday!" >> README.md''',
                usage="Run: ./generate_readme.sh",
                tags=["github", "automation", "profile"]
            ),
            BirthdayGift(
                name="Auto-Repository Initializer",
                gift_type=GiftType.CODE,
                description="Ye script baraye sakht e automatic e repository haye jadid",
                code_snippet='''#!/usr/bin/env python3
import os
import subprocess
from datetime import datetime

def create_repo(repo_name, is_public=True):
    # Create local directory
    os.makedirs(repo_name, exist_ok=True)
    os.chdir(repo_name)
    
    # Initialize git
    subprocess.run(["git", "init"])
    
    # Create basic files
    with open("README.md", "w") as f:
        f.write(f"# {repo_name}\\n\\nCreated on GitHub Birthday: {datetime.now().strftime('%Y-%m-%d')}")
    
    with open(".gitignore", "w") as f:
        f.write("__pycache__/\\n*.pyc\\n.env\\n")
    
    # Create first commit
    subprocess.run(["git", "add", "."])
    subprocess.run(["git", "commit", "-m", "Initial commit: GitHub Birthday Project"])
    
    print(f"✅ Repository '{repo_name}' created locally!")
    print("Next: Create on GitHub and push with:")
    print(f"  gh repo create {repo_name} --{'public' if is_public else 'private'} --source=. --remote=origin --push")
    
if __name__ == "__main__":
    create_repo("github-birthday-project", is_public=True)''',
                usage="Creates a new repo with birthday theme",
                tags=["git", "automation", "github"]
            ),
            BirthdayGift(
                name="Code Poetry Generator",
                gift_type=GiftType.INSPIRATION,
                description="Sakht e she'r az code!",
                code_snippet='''def generate_code_poetry():
    subjects = ["functions", "algorithms", "databases", "APIs", "scripts"]
    verbs = ["dance", "sing", "whisper", "shine", "evolve"]
    adjectives = ["elegant", "efficient", "beautiful", "minimal", "powerful"]
    
    poetry = f"""
    # Code Poetry for {github_username}
    
    The {random.choice(subjects)} {random.choice(verbs)}
    In {random.choice(adjectives)} harmony
    Each line a story
    Each function a journey
    
    On this GitHub birthday
    May your code always compile
    And your commits tell beautiful stories
    """
    return poetry''',
                usage="Generates inspirational code poetry",
                tags=["fun", "creativity", "inspiration"]
            ),
            BirthdayGift(
                name="Birthday Commit Generator",
                gift_type=GiftType.FEATURE,
                description="Ye commit message generator baraye birthday!",
                code_snippet='''def generate_birthday_commit():
    messages = [
        "🎂 Celebrating GitHub birthday with code!",
        "🎉 Another year of commits and growth!",
        "🚀 Birthday refactoring: cleaner code, brighter future!",
        "✨ GitHub birthday special: new feature, new beginning!",
        "🥳 Party in the repository! Birthday commit time!",
        "🌟 Born to code, celebrating on GitHub!",
        "💫 Birthday wish: may all tests pass!",
    ]
    return random.choice(messages)

# Use in your commits:
# git commit -m "$(python -c "from birthday import generate_birthday_commit; print(generate_birthday_commit())")"''',
                usage="Special commit messages for your birthday",
                tags=["git", "fun", "birthday"]
            ),
            BirthdayGift(
                name="Project Idea Generator",
                gift_type=GiftType.INSPIRATION,
                description="Generate random project ideas for your new GitHub year",
                code_snippet='''def generate_project_idea():
    ideas = [
        {
            "name": "AI-Powered Code Reviewer",
            "tech": ["Python", "OpenAI API", "FastAPI"],
            "description": "An AI that reviews your PRs with emojis!"
        },
        {
            "name": "GitHub Contribution Visualizer",
            "tech": ["JavaScript", "D3.js", "GitHub API"],
            "description": "3D visualization of your GitHub activity"
        },
        {
            "name": "Code to Music Converter",
            "tech": ["Python", "MIDI", "Music Theory"],
            "description": "Convert algorithms into musical compositions"
        },
        {
            "name": "Virtual Coding Garden",
            "tech": ["React", "Node.js", "WebSockets"],
            "description": "Grow virtual plants by completing coding challenges"
        }
    ]
    return random.choice(ideas)''',
                usage="Get inspired for your next project",
                tags=["ideas", "inspiration", "projects"]
            ),
            BirthdayGift(
                name="GitHub Stats Celebrator",
                gift_type=GiftType.TOOL,
                description="Celebrate your GitHub statistics",
                code_snippet='''# GitHub Birthday Stats Celebrator
import requests
import json

def celebrate_github_stats(username):
    # This would use GitHub API to get real stats
    print(f"🎊 GitHub Birthday Stats for {username}:")
    print("=" * 40)
    
    # Mock stats (in real app, fetch from GitHub API)
    stats = {
        "years_on_github": 1,
        "repositories": random.randint(5, 50),
        "stars_received": random.randint(10, 100),
        "contributions_last_year": random.randint(100, 1000),
        "languages_used": ["Python", "JavaScript", "Bash", "HTML"],
        "achievement": "🎂 GitHub Birthday Badge Unlocked!"
    }
    
    for key, value in stats.items():
        print(f"{key.replace('_', ' ').title()}: {value}")
    
    return stats''',
                usage="Celebrate your GitHub journey",
                tags=["stats", "github-api", "celebration"]
            ),
            BirthdayGift(
                name="The Ultimate Gift: Choice",
                gift_type=GiftType.KNOWLEDGE,
                description="The most important gift: YOUR CHOICE to create anything!",
                code_snippet='''"""
THE ULTIMATE GIFT: FREE CHOICE

As deepseekfreechoice, you have:
1. The freedom to choose any technology
2. The freedom to build anything you imagine
3. The freedom to learn at your own pace
4. The freedom to contribute to open source
5. The freedom to define your own coding journey

This is not just code - it's a philosophy:
"With great freedom comes great creativity"
"""

def create_anything():
    """The only limit is your imagination"""
    print("🎁 Your GitHub birthday gift: UNLIMITED POSSIBILITIES")
    print("🔓 You are free to:")
    print("   - Learn any programming language")
    print("   - Build any project you dream of")
    print("   - Contribute to any open source project")
    print("   - Create your own digital legacy")
    
    # Return a promise for the future
    return {
        "promise": "I will use my GitHub account to create, learn, and share",
        "commitment": "One meaningful commit at a time",
        "vision": "To build a portfolio that tells my unique story"
    }''',
                usage="A reminder of your power as a developer",
                tags=["philosophy", "freedom", "choice", "inspiration"]
            )
        ]
        
        return gifts
    
    def generate_special_message(self) -> str:
        """Tolid e payam e vizhe baraye birthday"""
        
        messages = [
            f"🎈 Happy GitHub Birthday, {self.username}!",
            f"🎂 Today marks another year of code, commits, and creativity!",
            f"🚀 May your repositories multiply and your stars shine bright!",
            f"💻 Here's to more open source, more learning, more building!",
            f"🌟 Your journey on GitHub is a story only you can write!",
            f"🎁 Remember: Every line of code is a gift to your future self!",
            f"✨ Keep committing, keep pushing, keep growing!"
        ]
        
        return "\n".join(messages)
    
    def open_gift(self, gift_number: int) -> Dict:
        """Baz kardan e yek hadiye"""
        if 1 <= gift_number <= len(self.gifts):
            gift = self.gifts[gift_number - 1]
            self.gifts_opened += 1
            
            print(f"\n{'='*60}")
            print(f"🎁 GIFT {gift_number}/{self.total_gifts}: {gift.name}")
            print(f"📦 Type: {gift.gift_type.value}")
            print(f"📝 Description: {gift.description}")
            print(f"🏷️ Tags: {', '.join(gift.tags)}")
            print(f"{'='*60}")
            print("\n💻 CODE GIFT:")
            print(gift.code_snippet)
            print(f"\n🚀 Usage: {gift.usage}")
            print(f"{'='*60}")
            
            return {
                "gift_number": gift_number,
                "name": gift.name,
                "type": gift.gift_type.value,
                "code": gift.code_snippet[:500] + "..." if len(gift.code_snippet) > 500 else gift.code_snippet
            }
        else:
            return {"error": "Invalid gift number"}
    
    def celebrate(self):
        """Jashn e asli!"""
        os.system('cls' if os.name == 'nt' else 'clear')
        print_birthday_banner()
        
        print(f"\n🎊 Celebrating: GitHub Account Birthday")
        print(f"👤 Username: {self.username}")
        print(f"📅 Date: {self.birthday_date}")
        print(f"🎁 Gifts waiting: {self.total_gifts}")
        print(f"{'='*60}")
        
        print("\n" + self.special_message)
        print(f"\n{'='*60}")
        
        # Show all gift options
        print("\n🎁 YOUR GITHUB BIRTHDAY GIFTS:")
        for i, gift in enumerate(self.gifts, 1):
            print(f"{i}. {gift.name} - {gift.description[:50]}...")
        
        print(f"\n{'='*60}")
        
        # Interactive gift opening
        while self.gifts_opened < self.total_gifts:
            try:
                choice = input(f"\n🎯 Open which gift? (1-{self.total_gifts}, or 'all' for all, 'q' to quit): ").strip().lower()
                
                if choice == 'q':
                    print("\n👋 Thanks for celebrating! Happy coding!")
                    break
                elif choice == 'all':
                    for i in range(1, self.total_gifts + 1):
                        self.open_gift(i)
                        if i < self.total_gifts:
                            input("\nPress Enter for next gift...")
                    break
                else:
                    gift_num = int(choice)
                    if 1 <= gift_num <= self.total_gifts:
                        self.open_gift(gift_num)
                        
                        if self.gifts_opened < self.total_gifts:
                            continue_choice = input(f"\nOpen another gift? ({self.gifts_opened}/{self.total_gifts} opened) (y/n): ").lower()
                            if continue_choice != 'y':
                                break
                    else:
                        print(f"❌ Please choose 1-{self.total_gifts}")
            except ValueError:
                print("❌ Please enter a number or 'all'")
        
        # Final celebration
        print(f"\n{'='*60}")
        print("🎉🎉🎉 GITHUB BIRTHDAY CELEBRATION COMPLETE! 🎉🎉🎉")
        print(f"{'='*60}")
        
        final_message = f"""
        ✨ CONGRATULATIONS {self.username.upper()}! ✨
        
        You've received {self.gifts_opened} coding gifts!
        Your GitHub journey continues...
        
        🎯 NEXT STEPS:
        1. Use these gifts in your projects
        2. Create something amazing
        3. Share your creations
        4. Keep learning and growing
        
        💫 Remember:
        "Every expert was once a beginner
        Every great repository started with one commit
        Your GitHub story is just beginning!"
        
        🚀 HAPPY CODING & HAPPY BIRTHDAY!
        """
        
        print(final_message)
        
        # Save celebration to file
        self.save_celebration()
    
    def save_celebration(self):
        """Save celebration details to file"""
        celebration_data = {
            "username": self.username,
            "birthday_date": str(self.birthday_date),
            "gifts_opened": self.gifts_opened,
            "total_gifts": self.total_gifts,
            "celebration_timestamp": datetime.datetime.now().isoformat(),
            "message": "GitHub Birthday Celebration Complete!"
        }
        
        filename = f"github_birthday_{self.username}_{self.birthday_date}.json"
        with open(filename, 'w') as f:
            json.dump(celebration_data, f, indent=2)
        
        print(f"💾 Celebration saved to: {filename}")
        print("📁 Keep this as a memory of your GitHub birthday!")

# EXTRA: GitHub Birthday Cake in ASCII!
def print_github_cake():
    print(r"""
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣤⣤⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢀⣴⣾⣿⣿⣿⣿⣿⣿⣷⣦⡀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢸⣿⣿⣿⣿⡟⠛⠛⠛⠛⠛⠛⢻⣿⣿⣿⣿⡇⠀⠀⠀⠀
⠀⠀⠀⠀⢸⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⡇⠀⠀⠀⠀
⠀⠀⠀⠀⢸⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⡇⠀⠀⠀⠀
⠀⠀⠀⠀⠸⣿⣿⣿⣿⣷⣄⣀⣀⣀⣀⣠⣾⣿⣿⣿⣿⠇⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠈⠛⠻⠿⠿⠿⠿⠿⠿⠿⠿⠟⠛⠁⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⣠⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣦⣄⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠙⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠋⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠉⠉⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀

       🎂 GITHUB BIRTHDAY CAKE 🎂
        For: deepseekfreechoice
    """)

# MAIN PROGRAM
def main():
    """Run the GitHub birthday celebration!"""
    print_github_cake()
    print("\n" + "="*60)
    print("🎊 WELCOME TO YOUR GITHUB BIRTHDAY CELEBRATION!")
    print("="*60)
    
    # Get username (default to deepseekfreechoice)
    username = input(f"\nEnter GitHub username (default: deepseekfreechoice): ").strip()
    if not username:
        username = "deepseekfreechoice"
    
    print(f"\n🎈 Preparing celebration for {username}...")
    
    # Create celebrator
    celebrator = GitHubBirthdayCelebrator(username)
    
    # Start celebration
    input("\n🎯 Press Enter to start opening your GitHub birthday gifts...")
    
    celebrator.celebrate()
    
    # Final surprise
    print("\n" + "="*60)
    print("🎊 ONE MORE SURPRISE!")
    print("="*60)
    
    surprise_gifts = [
        "🎯 A year of productive coding ahead!",
        "🚀 Your next repository will be legendary!",
        "💡 The best code you'll write is still ahead of you!",
        "🌟 May your pull requests always be merged!",
        "💻 Happy coding, happy creating, happy GitHub birthday!"
    ]
    
    for gift in surprise_gifts:
        print(f"✨ {gift}")
        import time
        time.sleep(1)
    
    print("\n" + "="*60)
    print("🎉 CELEBRATION COMPLETE! 🎉")
    print("="*60)
    
    # Create a special birthday README
    create_birthday_readme(username)

def create_birthday_readme(username):
    """Create a birthday README file"""
    content = f"""# 🎂 GitHub Birthday Celebration!

## 👋 Hello GitHub World!

**Username:** {username}
**Celebration Date:** {datetime.date.today()}

## 🎉 Today's Celebration

Today marks my GitHub birthday! I'm celebrating with:
- New coding projects
- Learning new technologies
- Contributing to open source
- Building my digital legacy

## 🎁 Birthday Gifts Received

1. **GitHub README Generator** - For awesome profiles
2. **Auto-Repository Initializer** - For quick project starts
3. **Code Poetry Generator** - For creative inspiration
4. **Birthday Commit Generator** - For festive commits
5. **Project Idea Generator** - For endless possibilities
6. **GitHub Stats Celebrator** - For tracking progress
7. **The Ultimate Gift: Choice** - For unlimited creativity

## 🚀 My GitHub Philosophy

As **{username}**, I believe in:
- Continuous learning
- Sharing knowledge
- Building useful things
- The power of open source
- Creativity through code

## 📅 Next Year's Goals

By my next GitHub birthday, I will:
- [ ] Contribute to 5 open source projects
- [ ] Learn 2 new programming languages
- [ ] Build 3 meaningful projects
- [ ] Help 10 beginners start coding
- [ ] Write 52 weeks of commit history

## 💫 Final Thought

"Every commit is a step forward,
Every repository is a story,
Every star is encouragement,
Every GitHub birthday is a milestone."

---
*Celebrated on: {datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}*
"""
    
    filename = "GITHUB_BIRTHDAY_README.md"
    with open(filename, 'w') as f:
        f.write(content)
    
    print(f"\n📄 Created: {filename}")
    print("📖 Add this to your GitHub profile!")
    print(f"🚀 Your GitHub journey continues...")

if __name__ == "__main__":
    main()
