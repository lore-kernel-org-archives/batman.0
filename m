Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 16 Apr 2012 20:30:43 +0200
References: <CAKLmikNxzz_zNwui4xejaAgvXXsHrTUGCPG+UT-cSH5iP3cEJw@mail.gmail.com>
	<201204161258.04262.lindner_marek@yahoo.de>
	<CAKLmikPWjXYVqQkJLK=j9DB_1+cNjLsrZ3j9kHGf6SiBbusOvw@mail.gmail.com>
In-Reply-To: <CAKLmikPWjXYVqQkJLK=j9DB_1+cNjLsrZ3j9kHGf6SiBbusOvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201204162030.43496.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Migration to Batman
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

On Monday, April 16, 2012 14:32:09 Mitar wrote:
> I am not sure what you mean by splits / joins. Yes, source is
> available. But I am not sure if this is what you had in mind?
> 
> I was just saying that route flapping (on/off) can be dealt with some
> aggregation of events on a consumer side. (But I am now unsure, maybe
> we are doing this already on the plugin side.)

I was talking about the scenario in which you have two mesh clouds consisting 
of roughly 100 nodes. These two clouds are barely connected via a single flaky 
link. Whenever this link vanishes you have 100 unreachable events and a minute 
later 100 reachable events and so on ..

Cheers,
Marek
