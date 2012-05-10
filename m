Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 10 May 2012 21:16:47 +0800
References: <4FA823EB.7070309@universe-factory.net>
	<201205091904.27376.lindner_marek@yahoo.de>
	<4FAA8634.7070809@universe-factory.net>
In-Reply-To: <4FAA8634.7070809@universe-factory.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201205102116.47554.lindner_marek@yahoo.de>
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

On Wednesday, May 09, 2012 22:59:00 Matthias Schiffer wrote:
> On 05/09/2012 01:04 PM, Marek Lindner wrote:
> > On Tuesday, May 08, 2012 22:18:34 Matthias Schiffer wrote:
> > How the rcu replace / update mechanism works is pretty clear to me. My
> > question geared towards our own code base. At which point would you use
> > this rcu update ? Every time an element in the hash is modified ?
> 
> Yes, my idea is to use this whenever a new packet is inserted into the
> vis hash to ensure the vis data a reader sees is always as consistant as
> possible. I know it wouldn't be fatal for the vis if a packet is missing
> from the data sometimes, but in my opinion a clean update is nicer :)

Feel free to propose patches to introduce this functionality. So far, we have 
been living without it but maybe we overlooked a potential side effect ?

Regards,
Marek
