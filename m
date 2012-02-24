Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 24 Feb 2012 21:14:33 +0800
References: <CAFevQmM12dq09+FPtwedGAXnJxw8rsCwphLAa-qfmaQFifErNg@mail.gmail.com>
	<4F42234D.4010703@gmail.com>
In-Reply-To: <4F42234D.4010703@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201202242114.33387.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] mesh: received packet with own address as source
	address
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

On Monday, February 20, 2012 18:41:17 Gioacchino Mazzurco wrote:
> But I think that in my case the problem was triggered by the fact that
> the two nodes has different batman-adv version one 2012.0.0 and the
> other 2011.4.0 ( and i supposed that the two version have incompatible
> loop avoidance )

No, both versions do have the same bridge loop avoidance code. The new bridge 
loop avoidance that you read a lot about has not been part of any release yet!

By the way, you can always check our release info to find out about what each 
release changes. You will notice 2012.0.0 is a bugfix release. No new features 
have been added. When incompatibilities of any kind occur they will be 
announced loud & clear.

Regards,
Marek
