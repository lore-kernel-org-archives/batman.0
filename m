Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 24 Aug 2012 15:53:17 +0200
References: <CA+h5Vgrcu=R7odK4av7cVs9Ov7+ZSXf0SgPM7riJ2HRpyYUvHA@mail.gmail.com>
 <6567295.mkEhlW2YzJ@bentobox>
 <CA+h5VgoW-uajF0dHti6eePGFOkcdzkesyEWRR2L6gNhkOG=2Og@mail.gmail.com>
In-Reply-To: <CA+h5VgoW-uajF0dHti6eePGFOkcdzkesyEWRR2L6gNhkOG=2Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201208241553.17222.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] editing the routing information
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Friday, August 24, 2012 14:01:15 Dominic Follett-Smith wrote:
> I will have a closer look at the code and send some more details over
> the weekend. Essentially I understand that neighbor ranking for a
> destination node 'D'  is performed on the number of OGM's received in
> the sliding window.

This is not entirely correct. Only single hop neighbors will count the 
received OGMs and also count the re-broadcasted OGMs repeated by its 
neighbors. Then they derive the TQ from that which is then propagated through 
the network (plus hop penalty and asym penalty).
In other words: N1 will never count the OGMs originating at D.

Cheers,
Marek
