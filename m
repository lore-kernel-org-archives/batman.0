Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 8 Jan 2013 20:52:12 +0800
References: <CAHQ_bgg4rRDVAhNce9SdONkFbF946EYrMgvT79kyp_bxk8T8NQ@mail.gmail.com>
 <201301081906.33146.lindner_marek@yahoo.de>
 <CAHQ_bgiL+tEz+3Lz+CFWH3Q-n7JhcDqSxRCQRxx-gcd=nYwjEw@mail.gmail.com>
In-Reply-To: <CAHQ_bgiL+tEz+3Lz+CFWH3Q-n7JhcDqSxRCQRxx-gcd=nYwjEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201301082052.12517.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Latency Related Problem
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
To: ajeet singh <ajeetbbr@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org


Hi,

you don't like the mailing list ? Why do you keep mailing me privately ? th=
is=20
is the last time I respond to mails you send to me privately concerning=20
batman-adv. Use the mailing list!

On Tuesday, January 08, 2013 19:36:45 you wrote:
> I am not comparing the ping between two nodes.
>=20
> I am just concerned about the ping latency between nodes.
>=20
> As per my experiment, I am getting 100ms delay between one hop(SPK3
> =E2=80=93to-SPK2) and 200 ms delay between two hops (SPK3-to-SPK1) and so=
 on.
>=20
> Even 100ms delay seems a lot, some applications may not work properly.
>=20
> Is there any delay (buffer) involved in local packet delivery from  bat0 =
to
> local mesh interfaces (wlan0)?

yes, there is standard wifi buffering. Consider this:

ping time from node1 to node2: ~100ms
ping time from node2 to node3: ~100ms

=3D> ping time from node1 to node3: ~200ms

The delays simply add up because wifi is a shared medium. The node in the=20
middle can only forward the packet while it does not receive. That is due t=
o=20
how wifi works and has nothing to do with batman-adv.

If you wish to mitigate the delay you should not use a shared medium. For=20
example using multiple wifi cards on different channels is a solution.

Cheers,
Marek
