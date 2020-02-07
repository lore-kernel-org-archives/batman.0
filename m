Return-Path: <srn@coolheads.com>
Subject: Re: can't find logged information
Reply-To: srn@coolheads.com
References: <24aa48bb-8f52-78be-28df-98ec2e2a054b@coolheads.com>
From: Steve Newcomb <srn@coolheads.com>
Message-ID: <b696db36-b9db-d31a-d8a6-0523f8a0986c@coolheads.com>
Date: Fri, 7 Feb 2020 10:18:19 -0500
MIME-Version: 1.0
In-Reply-To: <24aa48bb-8f52-78be-28df-98ec2e2a054b@coolheads.com>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
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


On 2/7/20 9:51 AM, Simon Wunderlich wrote:
> On Friday, February 7, 2020 3:13:47 PM CET Steve Newcomb wrote:
>> @rpc152:/tmp/log# echo "$(logread)" | grep batman
>> Thu Feb 6 15:21:13 2020 kern.warn kernel: [174193.938445] batman_adv:
>> [Deprecated]: batctl (pid 22747) Use of debugfs file "nc_nodes".
>> @rpc152:/tmp/log#
>>
>>
>> What have I missed?
> Hi Steve,
>
> you can use "batctl log" to retrieve the log. It will not appear in your
> logread.
Alas, that doesn't work either, and I don't know why:

root@rpc152:~# batctl log
Error - no valid command or debug table specified: log
Usage: batctl [options] command|debug table [parameters]
options:
 =A0=A0=A0=A0=A0=A0=A0 -h print this help (or 'batctl <command|debug table>=
 -h' for=20
the parameter help)
 =A0=A0=A0=A0=A0=A0=A0 -v print version

commands:
 =A0=A0=A0=A0=A0=A0=A0 meshif <netdev> aggregation|ag [0|1] display or modi=
fy=20
aggregation setting
...
>
> When the problem happens, you can also check "iw wlan0 station dump"=20
> and other
> debug files (batctl n for neighbors) to find out if the WiFi layer is=20
> still
> working. It wouldn't be the first time that actually the WiFi chip or=20
> driver
> has a problem, not batman-adv.
I've seen that "batctl n" works, and "iw mesh0 station dump" works, too.

I am arranging for the nodes to send me such mail when things have gone=20
awry, but prior to rebooting.=A0 I've written a tiny mail queueing system=20
that optionally uses nonvolatile memory for the queue.

