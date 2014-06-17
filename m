Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 17 Jun 2014 11:32:04 +0200
References: <1749487015.68950859.1402988675461.JavaMail.root@spooler5n-g27.priv.proxad.net>
In-Reply-To: <1749487015.68950859.1402988675461.JavaMail.root@spooler5n-g27.priv.proxad.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201406171132.04117.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] question about batman-adv auto run configuration
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: michael.holcman1@free.fr, Marek Lindner <mareklindner@neomailbox.ch>

> Hello,
> If i andersdood all the configuration in my following architecture, if i
> want to give IP address on each interfaces,i have to: - create a bridge on
> the PC,Wifi card and LTE card
> - creat a bat0 interface on each one,
> - i don't need to start /etc/conf/batman-adv enable since, when i installed
> kmod-batman-adv, i throw all the batman process.
> 
> I placed the config on the attached files
> 
> Tank's a lot for your help,

Hello Michael,

I don't think it's possible to use batman-adv over LTE (at least on raw LTE), 
since LTE is not an Ethernet Interface but an IP interface.

Cheers,
    Simon
