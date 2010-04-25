Return-Path: <adebex@gmail.com>
From: Adrian Byszuk <adebex@gmail.com>
Date: Sun, 25 Apr 2010 21:36:25 +0200
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201004252136.25395.adebex@gmail.com>
Subject: [B.A.T.M.A.N.] Security & node authentication in BATMAN network
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
To: "B.A.T.M.A.N. Mailing List" <b.a.t.m.a.n@lists.open-mesh.org>

Hello,

I'm currently working on project (part of my Bachelor work) which will use to 
transfer very sensitive data over the network, and I'd like to use mesh 
networks to transfer this data. Additionally, it should also be possible for 
"normal people" to connect to this network (e.g. to surf internet). 
Preliminary, I've chosen BATMAN to build this network. But I've got a few 
questions regarding security of this solution:

1. Does BATMAN provide any method of *authenticating* nodes?
As I've said earlier, sometimes transferred data will be highly sensitive (for 
example: information of patients health in hospital), so it's absolutely 
critical to not allow leaking this information. I can imagine situation when 
some fake nodes claim "Hey, I'm the server collecting this data"...
I think this is also important when someone would try to destroy our mesh 
network by placing some fake nodes in it.
2. If point nr one isn't possible, maybe there is some other way to ensure 
security? I don't know too much about security or cryptography, but I can 
think of solutions such as openVPN or IPsec.

Generally, the goal is to assert security of transmitting some data *without* 
losing open characteristics of mesh network.

I will very thankful for any answers.

Kind regards,
Adrian
