Return-Path: <javier@cozybit.com>
MIME-Version: 1.0
In-Reply-To: <20110831215506.GA27165@ritirata.org>
References: <4E5D69E3.30403@robotech.de>
	<CAKeC-QGag_c+g93MbiJWL9HB3iOczbfbatYUAA1wEEFSyvyd2g@mail.gmail.com>
	<20110831160712.GC25149@ritirata.org>
	<201108311816.23147.lindner_marek@yahoo.de>
	<20110831161833.GD25149@ritirata.org> <4E5E69DB.5060007@robotech.de>
	<20110831215506.GA27165@ritirata.org>
From: Javier Cardona <javier@cozybit.com>
Date: Wed, 31 Aug 2011 15:14:26 -0700
Message-ID: <CAPjQAd9kxw+0xQN3ht+NoHGLDoivtH_coutoW3F+CJ8_J2GR9A@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] batman-adv 2011.2.0 hop somtimes does not work
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

On Wed, Aug 31, 2011 at 2:55 PM, Antonio Quartulli <ordex@autistici.org> wr=
ote:
> On Wed, Aug 31, 2011 at 07:05:31 +0200, Tobias wrote:
>> [ =A0 =A0 25706] Creating new global tt entry: 00:02:81:b9:4c:c8 (via
>> 0a:18:84:1e:f6:05)
>> [ =A0 =A0 25707] Creating new global tt entry: 18:84:1e:f6:05:01 (via
>> 0a:18:84:1e:f6:05)
>> [ =A0 =A0 25707] Creating new global tt entry: 04:11:80:e4:a8:c8 (via
>> 0a:18:84:1e:f6:05)
>
> Here there is something strange..Do you know where do these macs belong
> (00:02:81:b9:4c:c8, 04:11:80:db:48:c8, 18:84:1e:f6:05:01)? Do you have cl=
ients
> connected to the mesh through the batman-adv nodes?

Couldn't help noticing that one mac is a one-byte right shift of the other:

(...)   (via 0a:18:84:1e:f6:05)
Creating (...) 18:84:1e:f6:05:01
---------------------^----------------^

Javier
