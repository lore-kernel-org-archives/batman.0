Return-Path: <ipmax2011@googlemail.com>
MIME-Version: 1.0
In-Reply-To: <201108101313.11132.lindner_marek@yahoo.de>
References: <CAJA-1LiiLCJ4D2s9ubXFRmyu_TvgiK51PAzaOHNMwP3M-KeeEg@mail.gmail.com>
	<201108101313.11132.lindner_marek@yahoo.de>
Date: Wed, 10 Aug 2011 13:50:48 +0200
Message-ID: <CAJA-1Lgog2nTsUpHBi3nxfjHOcxrQTKysBko1V0a8a9ojJfsKQ@mail.gmail.com>
From: Max Ip <ipmax2011@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Batman CPU usage
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

On Wed, Aug 10, 2011 at 1:13 PM, Marek Lindner <lindner_marek@yahoo.de> wro=
te:
> On Wednesday, August 10, 2011 12:43:58 Max Ip wrote:
>> When I checked the CPU usage at different nodes (using netperf), I
>> found the following results.
>>
>> TCP CPU utilization send local from C to B =3D 5.84%
>> TCP CPU utilzation send local from B to A =3D 2.37%
>> TCP CPU utilization from C to A (2-hop environment) =3D 9.19%
>>
>> UDP CPU utilization send local from C to B =3D 0.75%
>> UDP CPU utilization send local from B to A =3D 3.85%
>> UDP CPU utilization send local from C to A (2-hop environment) =A0=3D 4.=
31%
>
> May I ask how you measured the batman-adv CPU usage ? Or is this simply t=
he
> load created by netperf ?
>
> Before we can speculate why the load is so high / low, we need to know wh=
at
> was measured in the first place.
>
> Regards,
> Marek
>

For the test, I run netperf on server and client.

What I mean from by

TCP CPU utilization send local from C to B =3D 5.84%

is

netperf -H 192.168.101.156 -t TCP_STREAM -c -C

B (192.168.101.156) was set as netperf server and C was client. So,
from client we send default TCP_STREAM created by netperf. So, bulk
data transfer performance between 2 nodes can be measured in terms of
throughput and CPU utilization in sending data. For more details :

http://www.netperf.org/svn/netperf2/tags/netperf-2.5.0/doc/netperf.html#TCP=
_005fSTREAM

The receive socket size bytes, send socket size bytes and send message
size bytes were set to the default values i.e 87380, 16384 and 16384
respectively.
The command gave the CPU utilization of 5.84% on node C (sending node).

I hope the explanation is clear.

Thanks.
Max
