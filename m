Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 11 Feb 2010 17:00:18 +0800
References: <4B6F288E.8050406@muc.ccc.de> <4B7301BC.7080809@muc.ccc.de>
	<20100211023909.GB6493@Linus-Debian>
In-Reply-To: <20100211023909.GB6493@Linus-Debian>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201002111700.18403.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv 0.2 on openwrt
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

On Thursday 11 February 2010 10:39:09 Linus L=FCssing wrote:
> If I remember right, then you were saying that you're using the
> 8.09.2 release of OpenWRT. Otherwise you could have activated
> "Compile the kernel with symbol table information" under "make
> menuconfig" --> "Global build settings" to add some function names
> to those nice numbers :)

You can activate these settings manually:
make kernel_menuconfig ---> General setup  ---> Configure standard kernel=20
features (for small systems)  ---> Load all symbols for debugging/ksymoops

Regards,
Marek
