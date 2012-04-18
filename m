Return-Path: <mmitar@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20120417122257.GA3377@ritirata.org>
References: <CAKLmikPvKjzTL5CghzBZYWgPAhxVQVw3_usaTo0GGT26Z29mHA@mail.gmail.com>
	<20120417122257.GA3377@ritirata.org>
Date: Thu, 19 Apr 2012 01:38:39 +0200
Message-ID: <CAKLmikPkNyrZxtXfCgNfw1kv=gCcf6qzDBP7HH5SF0SE_tFHZA@mail.gmail.com>
From: Mitar <mmitar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] Determining on which node a client is connected
	to
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
Cc: Jernej Kos <kostko@unimatrix-one.org>

Hi!

Thank you all for all your answers. They really help me a lot!

On Tue, Apr 17, 2012 at 2:22 PM, Antonio Quartulli <ordex@autistici.org> wrote:
> However, I didn't get why you need the node MAC.

I think there was some misunderstand. I would just like to know on
which node a client is connected to. And as I understand, this is
globally shared between all nodes so I can just inspect this on one
node through global translation table. But for client I begin with the
IP. So with DHCP, I can get client's MAC, and from there I look into
global translation table. This tells me where the client is.


Mitar
