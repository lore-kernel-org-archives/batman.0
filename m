Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 10 Jan 2012 23:17:38 +0800
References: <mailman.1.1326193201.4676.b.a.t.m.a.n@lists.open-mesh.org>
	<4F0C39BE.3000209@inti.gob.ar>
In-Reply-To: <4F0C39BE.3000209@inti.gob.ar>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201201102317.38866.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] problem with mesh network
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

On Tuesday, January 10, 2012 21:14:38 gtolon@inti.gob.ar wrote:
> Yes, we suspected it could be a TX dma problem, because occasionally we
> found that error in the logs, so we followed some openwrt tickets
> related with that, but we're not sure that's the problem, and anyway it
> has not been solved yet. We've also asked on ath9k list about the driver
> debug files in case we could find something there, but they did't
> answered, I guess it's hard to explain in a mail list. We haven't asked
> to linux-wireless, maybe it would be better, since it could be something
> on top of the driver.

You can post the links to the specific tickets / open bug reports here. Maybe 
somebody has some information about it. Generally, the wifi lists are the 
better place to discuss these bugs.


> We were thinking in a script that managed the stations to connect to the
> different APs to avoid configuring each router manually. However we
> realized that with just one managed interface, each router could connect
> to only one AP, so if we wanted that every router could connect
> bidirectionally to others we should use a number of managed interfaces
> enough to connect to all neigbours,  shouldn't we?
> In any case it would be just another test to see if the results are
> different.

Correct, managed/AP is a one-to-one connection. If you want a router to 
connect to several APs you need an additional managed interface per 
connection.

Regards,
Marek
