#!/usr/bin/env python3
"""
MORGH-E-SABZ: Yek Dastan-e yek Morghe sarboride shode ast jeloye darbe khaneye aghaye sheydayi!
rafte bidam ke jakilidihamo post konam edare post baste bod bargashtani didam dame dare khaneye aghaye sheydayi khon rikhte bar hasabe hamsayegi raftam ta dame dare baze khaneye shan ke didam dame rah pele istade ast.! :)
Barname ye poksaz ke dar mored e "Tahavvol" sohbat mikonad.
"""

import random
import time
import sys
import os
from enum import Enum
from dataclasses import dataclass
from typing import List, Dict, Optional
import json

# ASCII Art haye ziba
def print_ascii_art():
    art = r"""
╔══════════════════════════════════════════╗
║   ░░░░░░░░░░   MORGH-E-SABZ   ░░░░░░░░░░ ║
║   A Pokemon-style Game with a Message!   ║
╚══════════════════════════════════════════╝
    
              ,-.
             /   \\
            |     |
            |     |
             \   /
              `-'
    """
    print(art)

# Enum baraye type haye pokemon
class Type(Enum):
    WATER = "آب 💧"
    FIRE = "آتش 🔥"
    GRASS = "گیاه 🌿"
    ELECTRIC = "برق ⚡"
    PSYCHIC = "روان 🔮"
    DARK = "تاریک 🌑"
    LIGHT = "نور ✨"
    EVOLUTION = "تکامل 🌀"

@dataclass
class Move:
    name: str
    damage: int
    type: Type
    description: str
    special_effect: Optional[str] = None

@dataclass
class Pokemon:
    name: str
    type: Type
    level: int
    hp: int
    max_hp: int
    moves: List[Move]
    evolution_stage: int
    experience: int
    required_exp: int
    story: str  # Dastan e pokemon
    
    def is_alive(self):
        return self.hp > 0
    
    def take_damage(self, damage):
        self.hp = max(0, self.hp - damage)
        return self.hp
    
    def heal(self, amount):
        self.hp = min(self.max_hp, self.hp + amount)
    
    def gain_exp(self, exp):
        self.experience += exp
        print(f"📈 {self.name} gained {exp} XP!")
        
        if self.experience >= self.required_exp:
            self.level_up()
    
    def level_up(self):
        self.level += 1
        old_max_hp = self.max_hp
        self.max_hp += random.randint(5, 15)
        self.hp = self.max_hp
        self.required_exp = int(self.required_exp * 1.5)
        
        print(f"\n✨✨✨ {self.name} leveled up to level {self.level}! ✨✨✨")
        print(f"❤️  HP increased: {old_max_hp} -> {self.max_hp}")
        
        # Dar level haye movaghat evolution
        if self.level in [5, 10, 15, 20]:
            self.evolve()
    
    def evolve(self):
        """Evolution dar in barname namayande ye "growth" ast!"""
        self.evolution_stage += 1
        print(f"\n🌀🌀🌀 {self.name} is EVOLVING! 🌀🌀🌀")
        time.sleep(1)
        
        evolution_messages = [
            f"{self.name} is learning from its experiences...",
            f"{self.name} is overcoming its weaknesses...",
            f"{self.name} is becoming stronger through challenges...",
            f"{self.name} is transforming through perseverance..."
        ]
        
        for msg in evolution_messages:
            print(f"   {msg}")
            time.sleep(1)
        
        # Increase stats baed on evolution
        old_max_hp = self.max_hp
        self.max_hp = int(self.max_hp * 1.3)
        self.hp = self.max_hp
        
        # Ezafe kardan ye move jadid
        new_moves = {
            2: Move("Growth Spurt", 25, Type.EVOLUTION, "یادگیری از اشتباهات", "heal_self"),
            3: Move("Adaptation", 30, Type.EVOLUTION, "سازگاری با شرایط جدید", "type_change"),
            4: Move("Transformation", 40, Type.EVOLUTION, "دگرگونی کامل", "stat_boost")
        }
        
        if self.evolution_stage in new_moves:
            self.moves.append(new_moves[self.evolution_stage])
            print(f"🎁 Learned new move: {new_moves[self.evolution_stage].name}")
        
        print(f"\n✅ Evolution complete! {self.name} reached stage {self.evolution_stage}")
        print(f"❤️  HP: {old_max_hp} -> {self.max_hp}")

class Player:
    def __init__(self, name):
        self.name = name
        self.pokemons = []
        self.active_pokemon = None
        self.badges = []
        self.items = {
            "Potion": 3,
            "Super Potion": 1,
            "Evolution Stone": 1
        }
    
    def add_pokemon(self, pokemon):
        self.pokemons.append(pokemon)
        if not self.active_pokemon:
            self.active_pokemon = pokemon
        print(f"🎉 {self.name} caught {pokemon.name}!")
    
    def switch_pokemon(self):
        if len(self.pokemons) > 1:
            print("\nYour Pokemon:")
            for i, pokemon in enumerate(self.pokemons):
                status = "💀" if not pokemon.is_alive() else "❤️"
                print(f"{i+1}. {pokemon.name} ({pokemon.type.value}) Lvl:{pokemon.level} HP:{pokemon.hp}/{pokemon.max_hp} {status}")
            
            try:
                choice = int(input("Select Pokemon (number): ")) - 1
                if 0 <= choice < len(self.pokemons):
                    if self.pokemons[choice].is_alive():
                        self.active_pokemon = self.pokemons[choice]
                        print(f"✓ Switched to {self.active_pokemon.name}")
                    else:
                        print("❌ That Pokemon has fainted!")
                else:
                    print("❌ Invalid choice")
            except:
                print("❌ Invalid input")
        else:
            print("❌ You only have one Pokemon!")

# GAME WORLD
class Game:
    def __init__(self):
        self.player = None
        self.opponents = []
        self.story_progress = 0
        self.messages = [
            "تکامل به معنای عالی شدن نیست، به معنای خود شدن است.",
            "هر اشتباه فرصتی برای یادگیری است.",
            "قوی ترین موجودات، آنهایی هستند که با تغییرات سازگار می‌شوند.",
            "تکامل درد دارد، اما رشد می‌آورد.",
            "تو همیشه در حال تغییر و رشد هستی، حتی اگر متوجه نشوی."
        ]
        
        # Sakht e starter pokemons
        self.starter_pokemons = [
            Pokemon(
                name="Morgh-e-Sabz",
                type=Type.GRASS,
                level=1,
                hp=45,
                max_hp=45,
                moves=[
                    Move("تندباد", 15, Type.GRASS, "بادهای تند طبیعت"),
                    Move("ریشه‌گیری", 10, Type.GRASS, "استفاده از ریشه‌ها", "heal_self")
                ],
                evolution_stage=1,
                experience=0,
                required_exp=100,
                story="یک مرغ عادی که تصمیم گرفت متفاوت باشد. هر روز کمی بیشتر از دیروز رشد می‌کند."
            ),
            Pokemon(
                name="Atash-Del",
                type=Type.FIRE,
                level=1,
                hp=40,
                max_hp=40,
                moves=[
                    Move("شعله", 20, Type.FIRE, "شعله‌های خالص"),
                    Move("گرمای درونی", 0, Type.FIRE, "گرم کردن خود", "stat_boost")
                ],
                evolution_stage=1,
                experience=0,
                required_exp=100,
                story="آتشی که از خاکسترهای تجربه‌های گذشته زاده شد. یاد گرفته کنترل شود نه خاموش."
            ),
            Pokemon(
                name="Aab-e-Zendegi",
                type=Type.WATER,
                level=1,
                hp=50,
                max_hp=50,
                moves=[
                    Move("موج", 18, Type.WATER, "موج‌های آرام"),
                    Move("جریان", 12, Type.WATER, "جریان ملایم آب", "type_change")
                ],
                evolution_stage=1,
                experience=0,
                required_exp=100,
                story="قطره‌ای که به دریا پیوست. انعطاف‌پذیر و همیشه در جریان، اما همیشه خودش باقی می‌ماند."
            )
        ]
        
        # Sakht e opponents
        self.create_opponents()
    
    def create_opponents(self):
        """Sakht e opponent haye ba dastan haye mohem"""
        opponents_data = [
            {
                "name": "کمال‌طلب",
                "pokemon": Pokemon(
                    name="Kamal-Talab",
                    type=Type.PSYCHIC,
                    level=3,
                    hp=60,
                    max_hp=60,
                    moves=[
                        Move("انتقاد سخت", 25, Type.PSYCHIC, "انتقاد بی‌رحم از خود"),
                        Move("ترس از شکست", 20, Type.DARK, "ترس از ناکامی")
                    ],
                    evolution_stage=1,
                    experience=0,
                    required_exp=0,
                    story="همیشه به دنبال بی‌عیب و نقص بودن است، اما فراموش کرده که رشد در پذیرش نقص‌هاست."
                ),
                "message": "کمال‌طلبی مانع رشد است. اجازه بده گاهی ناکامل باشی تا رشد کنی."
            },
            {
                "name": "تغییر‌گریز",
                "pokemon": Pokemon(
                    name="Taghir-Goriz",
                    type=Type.ROCK if hasattr(Type, 'ROCK') else Type.DARK,
                    level=5,
                    hp=70,
                    max_hp=70,
                    moves=[
                        Move("مقاومت در برابر تغییر", 30, Type.DARK, "پافشاری بر عادت‌های قدیمی"),
                        Move("منطقه امن", 15, Type.LIGHT, "پناه بردن به آشناها", "heal_self")
                    ],
                    evolution_stage=1,
                    experience=0,
                    required_exp=0,
                    story="از هر تغییر و تحولی می‌ترسد. نمی‌داند که تغییر همان زندگی است."
                ),
                "message": "تغییر ترسناک است، اما راکد ماندن مرگ تدریجی است."
            },
            {
                "name": "مقایسه‌گر",
                "pokemon": Pokemon(
                    name="Moghayese-Gar",
                    type=Type.PSYCHIC,
                    level=7,
                    hp=80,
                    max_hp=80,
                    moves=[
                        Move("مقایسه اجتماعی", 35, Type.PSYCHIC, "مقایسه خود با دیگران"),
                        Move("احساس کمبود", 25, Type.DARK, "احساس عدم کفایت")
                    ],
                    evolution_stage=1,
                    experience=0,
                    required_exp=0,
                    story="همیشه خودش را با دیگران مقایسه می‌کند و فراموش کرده که هر کس مسیر رشد خودش را دارد."
                ),
                "message": "مقایسه دزد شادی است. تو فقط باید با دیروز خودت مقایسه شوی."
            },
            {
                "name": "استاد تکامل",
                "pokemon": Pokemon(
                    name="Ostad-e-Takamol",
                    type=Type.EVOLUTION,
                    level=10,
                    hp=100,
                    max_hp=100,
                    moves=[
                        Move("پذیرش تغییر", 40, Type.EVOLUTION, "استقبال از دگرگونی"),
                        Move"خودشناسی", 30, Type.LIGHT, "شناخت عمیق خود"),
                        Move("رشد پیوسته", 50, Type.EVOLUTION, "تکامل دائمی", "stat_boost")
                    ],
                    evolution_stage=3,
                    experience=0,
                    required_exp=0,
                    story="استادی که فهمیده تکامل پایان ندارد، بلکه سفری همیشگی است."
                ),
                "message": "تبریک! تو معنی واقعی تکامل را فهمیدی: سفر، نه مقصد."
            }
        ]
        
        self.opponents = opponents_data
    
    def type_effectiveness(self, attack_type, defense_type):
        """System e effectiveness baraye type haye mokhtalef"""
        effectiveness_chart = {
            Type.FIRE: {Type.GRASS: 2.0, Type.WATER: 0.5},
            Type.WATER: {Type.FIRE: 2.0, Type.GRASS: 0.5},
            Type.GRASS: {Type.WATER: 2.0, Type.FIRE: 0.5},
            Type.ELECTRIC: {Type.WATER: 2.0},
            Type.PSYCHIC: {Type.DARK: 0.5},
            Type.DARK: {Type.PSYCHIC: 2.0, Type.LIGHT: 0.5},
            Type.LIGHT: {Type.DARK: 2.0},
            Type.EVOLUTION: {Type.DARK: 2.0, Type.PSYCHIC: 2.0, Type.LIGHT: 2.0}  # Evolution baraye hame moaser ast!
        }
        
        if attack_type in effectiveness_chart and defense_type in effectiveness_chart[attack_type]:
            return effectiveness_chart[attack_type][defense_type]
        return 1.0
    
    def print_with_delay(self, text, delay=0.03):
        """Chap e matn ba delay baraye dramatic effect"""
        for char in text:
            print(char, end='', flush=True)
            time.sleep(delay)
        print()
    
    def battle(self, player_pokemon, opponent_pokemon, opponent_name, opponent_message):
        """System e jang e pokemon"""
        print(f"\n{'='*60}")
        print(f"🎯 BATTLE AGAINST: {opponent_name}")
        print(f"{'='*60}\n")
        
        time.sleep(1)
        
        # Dastan e opponent
        self.print_with_delay(f"🤔 {opponent_name}: \"{opponent_message}\"")
        time.sleep(2)
        
        round_num = 1
        
        while player_pokemon.is_alive() and opponent_pokemon.is_alive():
            print(f"\n{'─'*40}")
            print(f"ROUND {round_num}")
            print(f"{'─'*40}")
            
            # Show status
            print(f"\n❤️  {player_pokemon.name}: {player_pokemon.hp}/{player_pokemon.max_hp} HP")
            print(f"⚡ {opponent_pokemon.name}: {opponent_pokemon.hp}/{opponent_pokemon.max_hp} HP")
            print(f"🎯 {opponent_name} is watching...")
            
            # Player's turn
            print(f"\n🎮 YOUR TURN:")
            print("1. Attack")
            print("2. Use Item")
            print("3. Switch Pokemon")
            print("4. Check Pokemon Info")
            
            try:
                choice = int(input("Choose action (1-4): "))
            except:
                choice = 1
            
            if choice == 1:  # Attack
                print(f"\n{player_pokemon.name}'s moves:")
                for i, move in enumerate(player_pokemon.moves):
                    print(f"{i+1}. {move.name} ({move.type.value}) - {move.description}")
                
                try:
                    move_choice = int(input("Choose move (number): ")) - 1
                    if 0 <= move_choice < len(player_pokemon.moves):
                        move = player_pokemon.moves[move_choice]
                        
                        # Calculate damage
                        base_damage = move.damage
                        effectiveness = self.type_effectiveness(move.type, opponent_pokemon.type)
                        damage = int(base_damage * effectiveness)
                        
                        # Apply damage
                        remaining_hp = opponent_pokemon.take_damage(damage)
                        
                        print(f"\n💥 {player_pokemon.name} used {move.name}!")
                        
                        if effectiveness > 1.0:
                            print(f"⭐ It's super effective! (x{effectiveness})")
                        elif effectiveness < 1.0:
                            print(f"😕 It's not very effective... (x{effectiveness})")
                        
                        print(f"⚡ {opponent_pokemon.name} took {damage} damage!")
                        print(f"❤️  {opponent_pokemon.name} HP: {remaining_hp}/{opponent_pokemon.max_hp}")
                        
                        # Special effects
                        if move.special_effect == "heal_self":
                            heal_amount = random.randint(5, 15)
                            player_pokemon.heal(heal_amount)
                            print(f"💚 {player_pokemon.name} healed {heal_amount} HP!")
                        
                    else:
                        print("❌ Invalid move choice!")
                        continue
                except:
                    print("❌ Invalid input!")
                    continue
                
            elif choice == 2:  # Use Item
                print(f"\n🎒 Your items:")
                for item, count in self.player.items.items():
                    print(f"  {item}: {count}")
                
                item_choice = input("Item to use (or 'cancel'): ").title()
                
                if item_choice == "Cancel":
                    continue
                elif item_choice in self.player.items and self.player.items[item_choice] > 0:
                    self.player.items[item_choice] -= 1
                    
                    if item_choice == "Potion":
                        heal_amount = 20
                        player_pokemon.heal(heal_amount)
                        print(f"💚 Used Potion! {player_pokemon.name} healed {heal_amount} HP!")
                    elif item_choice == "Super Potion":
                        heal_amount = 50
                        player_pokemon.heal(heal_amount)
                        print(f"💚 Used Super Potion! {player_pokemon.name} healed {heal_amount} HP!")
                    elif item_choice == "Evolution Stone":
                        print("💎 Evolution Stone shines brightly!")
                        print("✨ It reminds you: Growth takes time and patience.")
                        player_pokemon.gain_exp(50)
                else:
                    print("❌ No such item or item out of stock!")
                    continue
            
            elif choice == 3:  # Switch Pokemon
                self.player.switch_pokemon()
                player_pokemon = self.player.active_pokemon
                continue
            
            elif choice == 4:  # Check Info
                print(f"\n📋 {player_pokemon.name}'s Info:")
                print(f"   Type: {player_pokemon.type.value}")
                print(f"   Level: {player_pokemon.level}")
                print(f"   Evolution Stage: {player_pokemon.evolution_stage}")
                print(f"   XP: {player_pokemon.experience}/{player_pokemon.required_exp}")
                print(f"   Story: {player_pokemon.story}")
                continue
            
            else:
                print("❌ Invalid choice! Using default attack...")
                # Default attack
                damage = random.randint(10, 20)
                opponent_pokemon.take_damage(damage)
                print(f"💥 {player_pokemon.name} attacked for {damage} damage!")
            
            # Check if opponent fainted
            if not opponent_pokemon.is_alive():
                print(f"\n🎉 {opponent_pokemon.name} fainted!")
                
                # Experience gain
                exp_gain = opponent_pokemon.level * 20
                player_pokemon.gain_exp(exp_gain)
                
                # Show message from opponent
                print(f"\n💬 {opponent_name}: \"{opponent_message}\"")
                print("✨ You learned something valuable from this battle!")
                
                # Chance for item drop
                if random.random() < 0.3:
                    item = random.choice(["Potion", "Potion", "Super Potion"])
                    self.player.items[item] = self.player.items.get(item, 0) + 1
                    print(f"🎁 Found {item}!")
                
                return True  # Player won
            
            # Opponent's turn
            print(f"\n⚡ {opponent_name}'s TURN:")
            time.sleep(1)
            
            # Opponent chooses a move
            if opponent_pokemon.moves:
                move = random.choice(opponent_pokemon.moves)
                damage = move.damage
                effectiveness = self.type_effectiveness(move.type, player_pokemon.type)
                damage = int(damage * effectiveness)
                
                remaining_hp = player_pokemon.take_damage(damage)
                
                print(f"💥 {opponent_pokemon.name} used {move.name}!")
                print(f"⚡ {player_pokemon.name} took {damage} damage!")
                print(f"❤️  {player_pokemon.name} HP: {remaining_hp}/{player_pokemon.max_hp}")
            
            # Check if player fainted
            if not player_pokemon.is_alive():
                print(f"\n💀 {player_pokemon.name} fainted!")
                print("😔 You lost the battle, but gained experience...")
                
                # Still gain some experience
                exp_gain = opponent_pokemon.level * 5
                player_pokemon.gain_exp(exp_gain)
                
                # Healing after loss
                print("\n💚 Your Pokemon were healed at the Pokemon Center!")
                for pokemon in self.player.pokemons:
                    pokemon.hp = pokemon.max_hp
                
                return False  # Player lost
            
            round_num += 1
            time.sleep(1)
        
        return False
    
    def explore_world(self):
        """Explore kardan e donya ye bazi"""
        locations = [
            {
                "name": "جنگل خودشناسی",
                "description": "جایی که می‌توانی خودت را بهتر بشناسی.",
                "encounter_chance": 0.7,
                "item_find_chance": 0.4,
                "message": "شناخت خود، اولین قدم تکامل است."
            },
            {
                "name": "کوه چالش‌ها",
                "description": "چالش‌هایی که تو را قوی‌تر می‌کنند.",
                "encounter_chance": 0.8,
                "item_find_chance": 0.3,
                "message": "چالش‌ها فرصت‌هایی برای رشد هستند."
            },
            {
                "name": "دره تغییرات",
                "description": "جایی که همه چیز در حال تغییر است.",
                "encounter_chance": 0.6,
                "item_find_chance": 0.5,
                "message": "تغییر تنها چیز ثابت در زندگی است."
            },
            {
                "name": "معبد تکامل",
                "description": "مکانی مقدس برای رشد معنوی.",
                "encounter_chance": 0.5,
                "item_find_chance": 0.6,
                "message": "تکامل واقعی از درون آغاز می‌شود."
            }
        ]
        
        print("\n🌍 WORLD MAP:")
        for i, loc in enumerate(locations, 1):
            print(f"{i}. {loc['name']}")
            print(f"   {loc['description']}")
        
        try:
            choice = int(input("\nWhere do you want to go? (1-4): ")) - 1
            if 0 <= choice < len(locations):
                location = locations[choice]
                
                print(f"\n🚶 Traveling to {location['name']}...")
                time.sleep(2)
                print(f"\n📍 {location['name']}")
                print(f"📖 {location['description']}")
                print(f"💭 {location['message']}")
                
                # Random encounter
                if random.random() < location['encounter_chance']:
                    print("\n⚠️  Wild encounter!")
                    time.sleep(1)
                    
                    # Sakht e wild pokemon
                    wild_types = [Type.GRASS, Type.FIRE, Type.WATER, Type.ELECTRIC]
                    wild_pokemon = Pokemon(
                        name=random.choice(["کنجکاو", "ترسو", "شجاع", "خردمند"]),
                        type=random.choice(wild_types),
                        level=random.randint(1, 5),
                        hp=random.randint(30, 60),
                        max_hp=random.randint(30, 60),
                        moves=[
                            Move("حمله اولیه", random.randint(10, 20), random.choice(wild_types), "حمله ساده"),
                        ],
                        evolution_stage=1,
                        experience=0,
                        required_exp=0,
                        story="یک موجود وحشی که در حال یادگیری زندگی است."
                    )
                    
                    print(f"🌟 A wild {wild_pokemon.name} appeared!")
                    
                    action = input("What will you do? (1. Battle, 2. Run): ")
                    
                    if action == "1":
                        # Simple wild battle
                        print(f"\n⚔️ Battle with wild {wild_pokemon.name}!")
                        
                        while self.player.active_pokemon.is_alive() and wild_pokemon.is_alive():
                            # Player attacks
                            damage = random.randint(15, 25)
                            wild_pokemon.take_damage(damage)
                            print(f"💥 {self.player.active_pokemon.name} attacks for {damage} damage!")
                            
                            if not wild_pokemon.is_alive():
                                print(f"🎉 Wild {wild_pokemon.name} fainted!")
                                exp_gain = wild_pokemon.level * 15
                                self.player.active_pokemon.gain_exp(exp_gain)
                                break
                            
                            # Wild pokemon attacks
                            damage = random.randint(10, 20)
                            self.player.active_pokemon.take_damage(damage)
                            print(f"💥 Wild {wild_pokemon.name} attacks for {damage} damage!")
                            
                            if not self.player.active_pokemon.is_alive():
                                print(f"💀 {self.player.active_pokemon.name} fainted!")
                                break
                    
                    else:
                        print("🏃 You ran away safely.")
                
                # Find item
                if random.random() < location['item_find_chance']:
                    items = ["Potion", "Potion", "Super Potion", "Evolution Stone"]
                    found_item = random.choice(items)
                    self.player.items[found_item] = self.player.items.get(found_item, 0) + 1
                    print(f"\n🎁 You found a {found_item}!")
                
                # Random story event
                story_events = [
                    "در سفرت می‌فهمی که مهم مسیر است، نه مقصد.",
                    "هر قدم کوچک، بخشی از سفر بزرگ تکامل است.",
                    "گاهی باید گم شوی تا خودت را پیدا کنی.",
                    "رشد درد دارد، اما ثمره‌اش شیرین است."
                ]
                
                if random.random() < 0.5:
                    print(f"\n💡 Insight: {random.choice(story_events)}")
                
                return True
            else:
                print("❌ Invalid location!")
                return False
        except:
            print("❌ Invalid input!")
            return False
    
    def main_menu(self):
        """Menu asli ye bazi"""
        while True:
            print(f"\n{'='*60}")
            print("🏠 MAIN MENU")
            print(f"{'='*60}")
            print(f"Player: {self.player.name}")
            print(f"Active Pokemon: {self.player.active_pokemon.name} (Lvl: {self.player.active_pokemon.level})")
            print(f"Pokemon Count: {len(self.player.pokemons)}")
            print(f"Badges: {len(self.player.badges)}/4")
            print(f"{'='*60}")
            
            print("\n1. ⚔️  Battle Opponents (Face your inner demons)")
            print("2. 🌍 Explore World (Learn life lessons)")
            print("3. 📊 Check Pokemon Status")
            print("4. 🏥 Heal Pokemon")
            print("5. 🎒 Check Items")
            print("6. 💭 Read Story Messages")
            print("7. 🏆 Show Progress")
            print("8. ❌ Quit Game")
            print(f"{'='*60}")
            
            try:
                choice = int(input("\nChoose action (1-8): "))
            except:
                choice = 0
            
            if choice == 1:
                # Battle opponents
                if self.story_progress < len(self.opponents):
                    opponent = self.opponents[self.story_progress]
                    
                    print(f"\n🎯 OPPONENT {self.story_progress + 1}/{len(self.opponents)}")
                    print(f"Name: {opponent['name']}")
                    print(f"Message: {opponent['message']}")
                    
                    ready = input("\nReady to battle? (y/n): ").lower()
                    
                    if ready == 'y':
                        won = self.battle(
                            self.player.active_pokemon,
                            opponent['pokemon'],
                            opponent['name'],
                            opponent['message']
                        )
                        
                        if won:
                            self.player.badges.append(opponent['name'])
                            self.story_progress += 1
                            print(f"\n🏆 You earned the {opponent['name']} badge!")
                            print("✨ You're one step closer to understanding evolution!")
                            
                            if self.story_progress == len(self.opponents):
                                print("\n🎊🎊🎊 CONGRATULATIONS! 🎊🎊🎊")
                                print("You've completed your journey of self-evolution!")
                                print("Remember: The journey never really ends...")
                                time.sleep(3)
                else:
                    print("🎉 You've defeated all opponents! You are now a master of evolution!")
            
            elif choice == 2:
                self.explore_world()
            
            elif choice == 3:
                print("\n📊 YOUR POKEMON:")
                for i, pokemon in enumerate(self.player.pokemons):
                    print(f"\n{i+1}. {pokemon.name}")
                    print(f"   Type: {pokemon.type.value}")
                    print(f"   Level: {pokemon.level}")
                    print(f"   HP: {pokemon.hp}/{pokemon.max_hp}")
                    print(f"   Evolution Stage: {pokemon.evolution_stage}")
                    print(f"   XP: {pokemon.experience}/{pokemon.required_exp}")
                    print(f"   Story: {pokemon.story}")
                    
                    if pokemon.moves:
                        print(f"   Moves:")
                        for move in pokemon.moves:
                            print(f"     • {move.name}: {move.description}")
                
                input("\nPress Enter to continue...")
            
            elif choice == 4:
                print("\n🏥 Healing all Pokemon...")
                for pokemon in self.player.pokemons:
                    old_hp = pokemon.hp
                    pokemon.hp = pokemon.max_hp
                    print(f"💚 {pokemon.name}: {old_hp} -> {pokemon.hp} HP")
                print("All Pokemon are fully healed!")
            
            elif choice == 5:
                print("\n🎒 YOUR ITEMS:")
                if self.player.items:
                    for item, count in self.player.items.items():
                        print(f"  {item}: {count}")
                else:
                    print("  No items yet!")
                
                input("\nPress Enter to continue...")
            
            elif choice == 6:
                print("\n💭 WISDOM MESSAGES:")
                print("(These messages represent the game's deeper meaning)")
                print(f"{'─'*40}")
                
                for i, message in enumerate(self.messages, 1):
                    print(f"{i}. {message}")
                    time.sleep(1)
                
                print(f"\n{'─'*40}")
                print("🎮 Remember: This game is a metaphor for personal growth!")
                input("\nPress Enter to continue...")
            
            elif choice == 7:
                print("\n🏆 YOUR PROGRESS:")
                print(f"Player: {self.player.name}")
                print(f"Story Progress: {self.story_progress}/{len(self.opponents)}")
                print(f"Badges Earned: {len(self.player.badges)}")
                
                if self.player.badges:
                    print("\n🏅 Badges:")
                    for badge in self.player.badges:
                        print(f"  • {badge}")
                
                print(f"\n📈 Total Pokemon: {len(self.player.pokemons)}")
                
                if self.player.pokemons:
                    highest_level = max(p.level for p in self.player.pokemons)
                    print(f"🏆 Highest Level Pokemon: {highest_level}")
                
                # Calculate evolution percentage
                total_evolution = sum(p.evolution_stage for p in self.player.pokemons)
                max_possible = len(self.player.pokemons) * 4  # Max stage 4
                evolution_percent = (total_evolution / max_possible * 100) if max_possible > 0 else 0
                
                print(f"🌀 Evolution Progress: {evolution_percent:.1f}%")
                print("\n💡 The real progress is what you've learned about yourself!")
                
                input("\nPress Enter to continue...")
            
            elif choice == 8:
                print("\n👋 Farewell, traveler!")
                print("Remember: Evolution is a journey, not a destination.")
                print("Keep growing, keep evolving!")
                break
            
            else:
                print("❌ Invalid choice! Please try again.")
    
    def start(self):
        """Shoroo e bazi"""
        os.system('cls' if os.name == 'nt' else 'clear')
        print_ascii_art()
        
        self.print_with_delay("\n🎮 Welcome to MORGH-E-SABZ!")
        self.print_with_delay("A Pokemon-style game about PERSONAL EVOLUTION...")
        time.sleep(2)
        
        print("\n" + "="*60)
        print("📖 STORY:")
        self.print_with_delay("In a world where everyone is evolving...")
        self.print_with_delay("You begin a journey not to catch them all,")
        self.print_with_delay("but to understand what evolution truly means.")
        self.print_with_delay("")
        self.print_with_delay("🎯 This game is a METAPHOR for personal growth.")
        self.print_with_delay("Each battle represents overcoming inner challenges.")
        self.print_with_delay("Each Pokemon represents an aspect of yourself.")
        self.print_with_delay("Each evolution represents personal growth.")
        print("="*60)
        
        time.sleep(3)
        
        # Get player name
        player_name = input("\nWhat's your name, traveler? ")
        self.player = Player(player_name)
        
        # Choose starter Pokemon
        print("\n🌟 CHOOSE YOUR STARTER POKEMON:")
        print("(Each represents a different approach to growth)")
        
        for i, pokemon in enumerate(self.starter_pokemons, 1):
            print(f"\n{i}. {pokemon.name} ({pokemon.type.value})")
            print(f"   HP: {pokemon.hp}")
            print(f"   Story: {pokemon.story}")
        
        while True:
            try:
                choice = int(input("\nChoose your partner (1-3): ")) - 1
                if 0 <= choice < len(self.starter_pokemons):
                    starter = self.starter_pokemons[choice]
                    self.player.add_pokemon(starter)
                    break
                else:
                    print("❌ Please choose 1, 2, or 3.")
            except:
                print("❌ Please enter a number.")
        
        print(f"\n🎉 Excellent choice, {player_name}!")
        print(f"Your journey with {starter.name} begins now...")
        time.sleep(2)
        
        print("\n💡 REMEMBER:")
        print("This game is more than just battles.")
        print("It's about understanding GROWTH, CHANGE, and EVOLUTION.")
        print("Pay attention to the messages - they hold the real meaning!")
        time.sleep(3)
        
        # Show first wisdom message
        print(f"\n✨ WISDOM: {random.choice(self.messages)}")
        time.sleep(2)
        
        # Start main game
        self.main_menu()

# Run the game
if __name__ == "__main__":
    try:
        game = Game()
        game.start()
    except KeyboardInterrupt:
        print("\n\n👋 Game interrupted. Remember: Your evolution continues in real life!")
    except Exception as e:
        print(f"\n❌ Error: {e}")
        print("But in evolution, even errors teach us something!")
