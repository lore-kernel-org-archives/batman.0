Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 8 Jan 2013 15:44:27 +0800
References: <CAHQ_bgg4rRDVAhNce9SdONkFbF946EYrMgvT79kyp_bxk8T8NQ@mail.gmail.com>
In-Reply-To: <CAHQ_bgg4rRDVAhNce9SdONkFbF946EYrMgvT79kyp_bxk8T8NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201301081544.28105.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Latency Related Problem
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: ajeet singh <ajeetbbr@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org


Hi,

> I am using batman-adv for my project. I have configured my network in
> following topology,
> 
> 
> NODE 1 (STA|AP) ------ NODE 2 (STA|AP) ------ NODE 3 (STA|AP) ------
> 
> I am getting very high latency if I ping NODE 2 or NODE 3 from NODE 1. Ping
> latency is approx 100ms.
> 
> I am getting the normal delay ( 1ms) if I ping the Nodes without
> batman-adv.
>
> I have also tested with "batctl ping" and getting the same issue.

can you please provide packet dumps (tcpdump or wireshark) of the different 
traffic types flowing through your network ?

Which batman-adv version are you using ?

Cheers,
Marek
