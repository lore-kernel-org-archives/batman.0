Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 5 Oct 2009 22:01:30 +0800
References: <d9bba8670910050221m476d31eaodcdb8e9cdfbe8fa3@mail.gmail.com>
	<200910051849.49493.lindner_marek@yahoo.de>
	<d9bba8670910050512m41441532u5d28c6c2a476d152@mail.gmail.com>
In-Reply-To: <d9bba8670910050512m41441532u5d28c6c2a476d152@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200910052201.30645.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv and TCP problem
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

On Monday 05 October 2009 20:12:20 a wrote:
> No,
> 
> it is not a MTU problem. TCP packet are small (I'm sending only few
> characters) and big packet size (1400 byte) ping works

The limit on ethernet is 1500 bytes - please try that.
If that still works you should log the traffic on the GW with "batctl td" to see 
what your packets are doing. Feel free to post the log here if you need help.

Regards,
Marek
