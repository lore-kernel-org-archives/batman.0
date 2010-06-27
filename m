Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 27 Jun 2010 02:59:27 +0200
References: <Pine.LNX.3.95.1100626204505.1393Q-100000@nei>
In-Reply-To: <Pine.LNX.3.95.1100626204505.1393Q-100000@nei>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201006270259.28362.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv debug logging (v2)
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

On Sunday 27 June 2010 02:47:16 RHS Linux User wrote:
>    Would have the debugging available VIA the "usual" kernel process mean
> I could more easily turn on debugging. That is to say: I think I have a
> problem, I turn on debugging without having to recompile, etc. I can now
> easily observe what is going wrong and solve my problem more easily?

No, debugging can be turned on/off at runtime no matter where the logs end up 
(given you enabled the debugging option at compile time). Both systems behave 
identical in this aspect.
The question is: Should the routing logs go into the standard linux log or in 
a seperate file that only contains batman stuff. 

Cheers,
Marek
