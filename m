Return-Path: <jow@openwrt.org>
Message-ID: <5077EB2E.1040906@openwrt.org>
Date: Fri, 12 Oct 2012 12:04:30 +0200
From: Jo-Philipp Wich <jow@openwrt.org>
MIME-Version: 1.0
References: <CAMVTf1hohrQTfKbhD+SfhgX4xvdBZPvTATw+gLPjdek3VOU_zQ@mail.gmail.com>
 <50776C62.4040406@nixbits.net>
In-Reply-To: <50776C62.4040406@nixbits.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] How to create a Firmware o Image with a specific
 batman-adv configuration
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

Hey.

> That is very much all about openwrt and the wiki provides all the 
> information. When you build the image just ad your configuration
> files to "backfire/package/base-files/files/etc/config/

Don't do that. Not all targets use the base-files configs and its a
nuissance to have local changes while trying to stay in sync with the repo.

The proper wqay to overlay the build with custom configs is to create a
toplevel files/ directory and put the configs there, e.g.

files/etc/rc.local
files/etc/config/network

and so on. Toplevel here means the directory where you run make in.


Regards,
Jow
