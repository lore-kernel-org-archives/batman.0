Return-Path: <ordex@autistici.org>
Date: Tue, 6 Dec 2011 12:09:02 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20111206110826.GC4848@ritirata.org>
References: <4EDDE473.5020008@agblab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4EDDE473.5020008@agblab.com>
Subject: Re: [B.A.T.M.A.N.] TT inconsistency problem (again)
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

Hello Marko,

thank you for reporting the issue and for the high quantity (and quality) of
information you are giving us.

On Tue, Dec 06, 2011 at 10:46:27AM +0100, Marko Panger - AGB Lab wrote:
> [root@gtam00119 ~]# batctl ping 48:5d:60:b8:a3:0e
> PING 48:5d:60:b8:a3:0e (48:5d:60:b8:a3:0e) 20(48) bytes of data
> Reply from host 48:5d:60:b8:a3:0e timed out
> Reply from host 48:5d:60:b8:a3:0e timed out
> Reply from host 48:5d:60:b8:a3:0e timed out
> Reply from host 48:5d:60:b8:a3:0e timed out

Starting from this point I would say that the problem is "before" the TT
mechanism. batctl ping do not relies on the TTs as it directly use originator
(node) addresses. Usually, in this cases, the problem is in the connection
between nodes (most likely on the layer below).

> 
> And this is the output from 'batctl ll tt routes' from he node that is 
> being pinged (see above):
> 

[CUT]

From the log it is possible to see that the node is not receiving any TT_REPLY
message (which should solve the inconsistency being reported). This suggests us
that the previous statement is probably true ("the problem is 'before" the TT
mechanism").


Would you mind providing us the output of "batctl o" after the reboot on the
node where you take the tt log?
Moreover, could you please attach the output of "batctl td WIFI_IFACE" either on
the unreachable node and on another one (maybe a2:f6?)

Cheers,


-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
