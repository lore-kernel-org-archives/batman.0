Return-Path: <lambertarthur22@gmail.com>
MIME-Version: 1.0
From: Arthur Lambert <lambertarthur22@gmail.com>
Date: Tue, 3 Jul 2012 10:57:28 +0200
Message-ID: <CAGpqJgoJ2V5TNcr5j+c=y88Vj4ipE0ke=y9ZDKqOvsaci+u54A@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] [B.A.T.M.A.N] OGM problem and documentation
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi,

I am testing Batman Advance (Batman release 2012 1.0) and I am trying
to measure signaling on some topology of VMs. I have 81 nodes (Debian,
3.0.9) with KVM virtualization. My topology is something like this :
http://imgur.com/Xh1gM


I have a topology with an adjacency matrix of maximum 4 as you can see
on my screenshot. I record on each VM signaling received and sent. On
some VM, my node send OGM at each "orig_interval" but does not receive
any OGM at all.

Is it normal ?

Moreover, I have found a wonderful documention here :
http://gitorious.org/batman-adv-doc. Unfortunatly, it is not maintened
since two years. I have also found some papers which describe your
protocol, but most of the time, the paper are too old or not correct
in the protocol description. At this moment, my first source of
information is the code. Can you advise me a good paper or
documentation on the architecture and features of Batman Advance set
apart your twiki.

Kind regards, my apology for my English.

-- 
Arthur
