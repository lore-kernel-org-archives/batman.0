Return-Path: <dandenson@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAL3ir7LUCHfyxegLn7qbx8cQ_H73V6AnTtBBN2eUPg7Wwn3j+A@mail.gmail.com>
References: <CAL3ir7LUCHfyxegLn7qbx8cQ_H73V6AnTtBBN2eUPg7Wwn3j+A@mail.gmail.com>
From: dan <dandenson@gmail.com>
Date: Sun, 31 Dec 2017 12:54:03 -0700
Message-ID: <CAA_JP8VQAZH+SAMU+CcHSQQZ29eGirt8CHX_8DS1EpjH7NO2KA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] 11ac throughput on mesh links
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

1/6 connection rate speed is pretty typical in 80Mhz channels unless
you are in a very truly clean environment and your walls aren't
reflective etc etc.  This is why MIMO/MU-MIMO is such a big thing and
you don't have that going for you.  That=E2=80=99s not a Batman-adv thing.
You should try 20 and 40 MHz channels and see how that works out.

Also, the tx rate is very low.  I=E2=80=99m not sure how accurate this test=
 is
or if uses some ack or something that would rely on the tax.  I would
try an iperf test between nodes to get a more accuarate number.

Also, are there other radios?

On Sun, Dec 31, 2017 at 6:41 AM, Daniel Ghansah <smartwires@gmail.com> wrot=
e:
> I am testing an implementation of
> batman-adv, alfred, 802.11s, 11ac.
> In this implementation I have my mesh interface on the 5GHz radio
> (qca9882), Using LEDE/Openwrt  17.01.04
>
> I am getting
>
> root@Daniel Node:~# batctl tp 9c:b7:93:e3:56:e4
> Test duration 10020ms.
> Sent 142966836 Bytes.
> Throughput: 13.61 MB/s (114.15 Mbps)
> is this inline with what everyone has seen. That data rate established is
> high however the throughput is very low
>
> root@Daniel Node:~# iw mesh0 station dump
> Station 9c:b7:93:e3:56:e4 (on mesh0)
>         inactive time:  100 ms
>         rx bytes:       75007154
>         rx packets:     910406
>         tx bytes:       968480244
>         tx packets:     635811
>         tx retries:     0
>         tx failed:      7
>         rx drop misc:   15
>         signal:         -45 dBm
>         signal avg:     -44 dBm
>         Toffset:        18446744061225933893 us
>         tx bitrate:     6.0 MBit/s
>         rx bitrate:     650.0 MBit/s VHT-MCS 7 80MHz short GI VHT-NSS 2
>         rx duration:    10763380 us
>         mesh llid:      44135
>         mesh plid:      29835
>         mesh plink:     ESTAB
>         mesh local PS mode:     ACTIVE
>         mesh peer PS mode:      ACTIVE
>         mesh non-peer PS mode:  ACTIVE
>         authorized:     yes
>         authenticated:  yes
>         associated:     yes
>         preamble:       long
>         WMM/WME:        yes
>         MFP:            no
>         TDLS peer:      no
>         DTIM period:    2
>         beacon interval:100
>         short slot time:yes
>         connected time: 12825 seconds
>
> What may I be doing wrong?
