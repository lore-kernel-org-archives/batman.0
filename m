Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 13 Apr 2012 00:17:31 +0200
References: <CAKLmikNxzz_zNwui4xejaAgvXXsHrTUGCPG+UT-cSH5iP3cEJw@mail.gmail.com>
	<4F86B02B.9060900@gmail.com>
	<CAKLmikNuMEiG2SN+H8bJkwRXszMayPpn_qDcf1faCjhrow6NdQ@mail.gmail.com>
In-Reply-To: <CAKLmikNuMEiG2SN+H8bJkwRXszMayPpn_qDcf1faCjhrow6NdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201204130017.31711.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Migration to Batman
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
Cc: Jernej Kos <kostko@unimatrix-one.org>

On Thursday, April 12, 2012 19:05:54 Mitar wrote:
> > In batman-adv you can add/remove interfaces at runtime without problems
> > so you doesn't need bridging or similar nasty things
> 
> Great. Can you also say to work on all "tun+" interfaces, so that any
> interface which starts with "tun" is automatically operated on?

No, batman-adv is not a user space daemon with a configuration file, hence you 
can't tell batman-adv to wait for tun+. However, you can easily write a simple 
shell script for hotplug which adds whatever interface you want to batman-adv 
as soon as it is created.
Or, if you are using OpenWrt, you can simply extend the existing hotplug shell 
script to interprete the "+" as you like.

Regards,
Marek
 
