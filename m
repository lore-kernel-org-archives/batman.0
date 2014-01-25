Return-Path: <crockabiscuit@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20140124164713.7e0fceadfe444297f4fd7350@gmx.net>
References: <CAL0=0H2MA7WVq7wkEBsatEOV1S-RevY2KXSHeAEgHsLdtBddRA@mail.gmail.com>
 <20140124164713.7e0fceadfe444297f4fd7350@gmx.net>
Date: Sat, 25 Jan 2014 09:29:12 +0900
Message-ID: <CAL0=0H2-u+NQhXNiYc=EuZkY9ZsK5dc7o1ka3_tVmoovJbpopA@mail.gmail.com>
From: crocket <crockabiscuit@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Is BATMAN alone enough to create wireless mesh
	networks?
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

So is BATMAN a full-fledged alternative to 802.11s?

On Sat, Jan 25, 2014 at 12:47 AM, Elektra <onelektra@gmx.net> wrote:
> Hi  =96
>
> B.A.T.M.A.N. refers to a routing algorithm.
>
> There are implementations of the routing algorithom at OSI layer 2 (batma=
n-advanced) and layer 3 (batmand, bmx6)
>
> You can use all 3 variants for Android to build wireless mesh networks an=
d people are actually doing so (Serval)
>
> Integrating batman-advanced into Android requires you to not only have ro=
ot, but also provide a batman-adv kernel module that fits the kernel of the=
 device. This is fine, if someone like Google or Cyanogenmod would enclude =
batman-adv in their Android builds, which would merely require to enable bu=
ilding the module in the kernel build process, as it is shipped with the va=
nilla kernel sources.
>
> batmand and bmx6 are user space programs that merely alter the routing ta=
ble. Integrating these is easier, since you merely require root permissions=
 to run them.
>
> Cheers,
> Elektra
>
>
>> I've been searching for wireless mesh network solutions.
>> BATMAN showed up in google search results.
>>
>> I just wonder its role and the future of it, and I want to know if it
>> can power wireless mesh networks in android phones.
>
>
> --
> Elektra <onelektra@gmx.net>
