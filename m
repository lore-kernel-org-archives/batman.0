Return-Path: <tonyputi@gmail.com>
MIME-Version: 1.0
From: Filippo Sallemi <tonyputi@gmail.com>
Date: Sat, 26 May 2012 19:33:02 +0200
Message-ID: <CAFevQmPp152mUiJfjm-476=ASnCZEh0UQbhvjKAyeaxHwJ=Tow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] hotplug.d
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi all,

there is an error in /etc/hotplug.d/net/99-batman-adv at line 9.

The function that be called is bat_config and not config_bat

Could someone fix it in latest batman-adv stable release?

Rgds

-- 
Filippo Sallemi
