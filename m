Return-Path: <sailashm@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
From: sailashm@gmail.com
In-Reply-To: <24448293.C3avDh6gQR@sven-edge>
Date: Sat, 25 Jun 2016 10:04:41 +0530
Content-Transfer-Encoding: quoted-printable
Message-Id: <0F40DD26-09F6-4ED6-B0BC-7413FF5ED713@gmail.com>
References: <CAM3k=84krmoLaW2X59VujDb_ZxuMJW-6pwGDhDLx=0-HHG6O=Q@mail.gmail.com>
 <CAM3k=84yf5iiZqYrzTK2cSwJGM8cmRH4Vf9cJxthz4Lp3dowCg@mail.gmail.com>
 <9404219.qzAPb65udo@bentobox> <24448293.C3avDh6gQR@sven-edge>
Subject: Re: [B.A.T.M.A.N.] Adhoc0 Interface not showing up
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hi Sven,

I will give it a shot on monday and let you know. However, when using the BA=
TMAN-adv in my 5 tplink routers, the AP interface keeps disconnecting and is=
 not stable. The version of batman-adv is 14. Is this version of batman-adv u=
nstable?

Thanks,
Sailash M

> On 25-Jun-2016, at 1:27 AM, Sven Eckelmann <sven@narfation.org> wrote:
>=20
>> On Thursday 23 June 2016 12:53:35 Sven Eckelmann wrote:
>> [...]
>> "ip link" shows that the adhoc0 interface is down. Please make
>> sure that the interface goes up. This is now definitely an
>> OpenWrt+wifi driver question and not related to batman-adv.
>>=20
>> The interface combination [1] is showing only
>> "#{ managed, AP, mesh point } <=3D 8,". So you can try to
>> deactivate your AP interface in /etc/config/wireless. Make
>> sure that you only see the adhoc0 interface in `iw dev`
>> after you've restarted the wifi.
>=20
> Any success when only using adhoc0 without the extra AP interface?=20
>=20
> Kind regards,
>    Sven
