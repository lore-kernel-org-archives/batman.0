Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 4 Nov 2011 10:47:52 +0100
References: <CAOaDhSSVMx1eN1G5rZ6-zh8Kh8xoddUOiQ0ua4StaX5bLHVQ7w@mail.gmail.com>
	<201110311048.50063.lindner_marek@yahoo.de>
In-Reply-To: <201110311048.50063.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201111041047.52997.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman miss crc16 module after nico commit
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Nodi Roma List <nodi-roma@ml.ninux.org>, riot-workshop@googlegroups.com

On Monday, October 31, 2011 10:48:49 Marek Lindner wrote:
> > https://dev.openwrt.org/changeset/28657/packages/net/batman-adv/Makefile
> 
> the OpenWrt developers have renamed the package dependency. Unless you are 
> using the OpenWrt trunk after revision 28656 the package dependency
> selection  won't work anymore.
> 
> Maybe you should ask them about their concept of backward compatibility.

I have to roll back here. You are using backfire while grabbing the packages 
from trunk. You are not supposed to do that. There is a specific backfire 
branch maintained by the OpenWrt developers which is kept compatible (I wasn't 
aware of that).

If you mix backfire and trunk you have to deal with the consequences yourself.

Regards,
Marek
