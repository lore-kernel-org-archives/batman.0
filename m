Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 3 May 2010 08:28:08 +0800
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201005030828.08856.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] sysfs compat
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
To: b.a.t.m.a.n@lists.open-mesh.org


Hi,

the current trunk contains some code which breaks our backward compatibility, 
especially the sysfs API seem to be troublesome. I made 2 patches that address 
the issue on my 2.6.21 test system. It would be nice if you could test them on 
your system as well. I'd be particularly interested in kernels older than 
2.6.25. Does someone have a 2.6.20 system ?

At some point we have to start thinking about how many versions we want to 
support. Each new kernel brings more changes which need to be dealt with. 
Right now, the required effort is still at a sustainable level but the gap is 
growing. On one hand it is a nice playground to expand our knowledge about 
macros and demonstrate what nasty things you can do (see the second patch as 
an example).  ;-)
On the other hand it always requires a serious amount of time and effort. It 
only makes sense if at least some people are using it. Opinions ?

Regards,
Marek
