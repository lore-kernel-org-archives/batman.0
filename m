Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 9 May 2012 19:04:27 +0800
References: <4FA823EB.7070309@universe-factory.net>
	<201205081359.26707.lindner_marek@yahoo.de>
	<4FA92B3A.40000@universe-factory.net>
In-Reply-To: <4FA92B3A.40000@universe-factory.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201205091904.27376.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] The current state of the batman-adv vis code
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

On Tuesday, May 08, 2012 22:18:34 Matthias Schiffer wrote:
> It would be useful to keep the output consistent even when the hash is
> updated while the output is generated - as a delete-add sequence adds
> the new element at the head of the hlist, a RCU-locked reader will not
> see the element when the traversal position is between the head and the
> old position of the element. An hash_update could use
> hlist_replace_rcu() to replace an element in a way that each reader
> either sees the old or the new version, but none loses it completely.
> 
> A hash_update_if version that gets an additional callback that is
> provided with the old and the new element and gets to decide which
> element to keep in the hash could be used to compare the sequence
> numbers in the vis code and update the hash atomically.

How the rcu replace / update mechanism works is pretty clear to me. My 
question geared towards our own code base. At which point would you use this 
rcu update ? Every time an element in the hash is modified ?

Regards,
Marek
