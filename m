Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 6 Dec 2011 22:10:09 +0800
References: <4EDDE473.5020008@agblab.com> <20111206134914.GB6839@ritirata.org>
	<4EDE1E9A.7080702@agblab.com>
In-Reply-To: <4EDE1E9A.7080702@agblab.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201112062210.09978.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] TT inconsistency problem (again)
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

On Tuesday, December 06, 2011 21:54:34 Marko Panger - AGB Lab wrote:
> On 12/6/2011 2:49 PM, Antonio Quartulli wrote:
> > Because you probably didn't add the crc16 module in the openwrt
> > menuconfig (you are using openwrt right?)
> 
> No, I'm using a custom build kernel with Fedora 12 as the base.

The standard kernel also selects the crc16 module for you as soon as batman-
adv is selected. Maybe you simply forgot to load the crc16 module ?

Regards,
Marek
