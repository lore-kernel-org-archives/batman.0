Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 1 Jun 2012 14:31:10 +0800
References: <4fc2d386.64e1440a.393f.ffff929f@mx.google.com>
In-Reply-To: <4fc2d386.64e1440a.393f.ffff929f@mx.google.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201206011431.11192.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Can't create new originator
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
Cc: "puyou.lu" <puyou.lu@gmail.com>

On Monday, May 28, 2012 09:23:11 puyou.lu wrote:
> Every nodes run the same version of batman.
> I attatch the topology of my mesh network.When b0:c6:9b:80:01:53 is on
> (working),b0:c6:9b:80:01:5f can reach b0:c6:9b:80:01:43,and the hole
> network is ok.b0:c6:9b:80:01:5b's nexthop to b0:c6:9b:80:01:43 is
> b0:c6:9b:80:01:57 or b0:c6:9b:80:01:6c, and sometimes b0:c6:9b:80:01:53.
> But when I shut b0:c6:9b:80:01:53 down,it seems b0:c6:9b:80:01:5b can't
> reach b0:c6:9b:80:01:57 neither b0:c6:9b:80:01:6c,as I mentioned in my
> firt email. When I turn b0:c6:9b:80:01:53 on again,the hole mesh is ok
> again.
> Marek,can you tell me what the problem probably is.

The mesh connections are too weak without b0:c6:9b:80:01:53 ? 
I don't really have an idea what your setup is and how it looks like to draw 
any meaningful conclusion.

Regards,
Marek
