Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 15 Jun 2011 22:23:21 +0200
References: <4DF90276.8050701@aon.at>
	<201106152122.30123.lindner_marek@yahoo.de>
	<4DF907DB.2070802@aon.at>
In-Reply-To: <4DF907DB.2070802@aon.at>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201106152223.21903.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Linux bridge-code for something like BATMAN
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

On Wednesday, June 15, 2011 09:28:27 PM fboehm wrote:
> unfortunately I am stuck with an older kernel where I can't use BATMAN.
> And everytime I am dealing with linux bridge configuration this idea
> comes into my mind.

If you can't upgrade your kernel you need to develop that for your old kernel 
version. BATMAN supports up to 2.6.21 which already is ancient ..


> At the moment it's just an idea but before starting some experiments I
> would like to get some feedback.

Then you have to explain your idea in greater detail. Feeding mac addresses 
into the bridge module alone is not going to make layer2 routing work.

Regards,
Marek
