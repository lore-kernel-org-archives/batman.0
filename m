Return-Path: <andrew@lunn.ch>
Date: Thu, 13 Mar 2014 18:53:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20140313175333.GG15090@lunn.ch>
References: <CAMcTwKrV4OVZP6v3hD2_4t8DWsmymGYgu9xMZa6aexrWQuORtQ@mail.gmail.com>
 <53218FEB.8000100@meshcoding.com>
 <CAMcTwKqi+zDUmP-6877Wgs681Qx8jbuY2+gi_7LO0M63e+1nCw@mail.gmail.com>
 <5321B5AE.9080005@meshcoding.com>
 <CAMcTwKrw+U7xZckqmcurrc8z4UZTkt50SqQ_esFHKo_D2Grf_A@mail.gmail.com>
 <5321DB08.50502@tu-bs.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5321DB08.50502@tu-bs.de>
Subject: Re: [B.A.T.M.A.N.] IP connection lost when a node is rebooted
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Thu, Mar 13, 2014 at 05:21:28PM +0100, Harms, Hannes wrote:
> Dear list,
> im wondering if it is possible to just compile the latest release of
> batman-adv and replace the existing  kernel module on an Debian
> System.
> It is not necessary to have  a propriate kernel version  e.g. 3.13 ?

The batman-adv sources will compile against some older kernels. So as
long as you have a recent Debian, e.g. Jessie or Wheezy, you should be
able to install the kernel headers packages and then compile the
kernel module.

       Andrew,
