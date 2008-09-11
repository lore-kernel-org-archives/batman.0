From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 11 Sep 2008 13:47:41 +0800
References: <8c906fa50809100941y79bc2011nd234780ad7b5cd0@mail.gmail.com>
	<200809111101.31420.lindner_marek@yahoo.de>
	<5635aa0d0809102122s4f528693o3aeb1795ce640d4e@mail.gmail.com>
In-Reply-To: <5635aa0d0809102122s4f528693o3aeb1795ce640d4e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200809111347.41152.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] BATGAT
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

On Thursday, 11. September 2008 12:22:42 Outback Dingo wrote:
> http://pastebin.com/m1677070a
>
> batgat crashed out, and unloaded without batgat batman routes never stay

That does not look like a crash ?! Is your log related to the issue mentioned 
by the original reporter ? He said his batmand crashes and the kernel module 
is still alive.

To debug your issue a tcpdump on UDP port 4306 would help. So we can see what 
packages are sent forth and back.

Greetings,
Marek
