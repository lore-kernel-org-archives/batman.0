Return-Path: <andrew@lunn.ch>
Date: Wed, 9 Oct 2013 23:48:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20131009214810.GB14447@lunn.ch>
References: <1380899775-25238-1-git-send-email-andrew@lunn.ch>
 <70C9D015-5815-4EDA-A427-F496906D18EE@dymos.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70C9D015-5815-4EDA-A427-F496906D18EE@dymos.org.uk>
Subject: Re: [B.A.T.M.A.N.] a question regarding ALFRED
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

On Wed, Oct 09, 2013 at 05:34:00PM +0100, Stephen Thornton wrote:

Hi Stephen

Please could you fix your mail client to keep lines short than around
70 characters.

> I am currently developing a mesh router solution for several clients. I have been using batman-adv in this project for almost a year (using OpenWRT), and it has all worked fantastically. Thanks so much guys.
> I now have a requirement for GPS logging functionality, along with passing other data between nodes. I have already written a simple layer3 protocol for this purpose, but this was before ALFRED. ALFRED provides almost all the functionality I need apart from the fact that I really need to embed the alfred code within my own application. I could use it as is via a sys call, but it would be so much better to include the code. What are your feelings regarding splitting the alfred code into a library with can be included in other user applications, and an alfred client program that uses this library? I'm quite prepared to give quite a bit of my own time to doing this if you like the idea.

Are you interested in using alfred, or vis built on top of alfred?
Would you want a library for accessing alfred, or for accessing vis?

You could pull some of the boilerplate code out of vis and my
alfred-gpsd server/client into a library. e.g. alfred_open_sock(),
_publish_data(), _request_data(), _receive_answer_packet(),
_get_data(). What will cause problems is the globals structure.  It is
a mixture of generic and application specific members. That will
require quite a bit of refactoring.

I'm just not sure it is worth the effort. It took me less than a
mythical man day to get a proof of concept gpsd code working, and
another day to sort out output formatting issues and the odd bug, etc.
Creating a new client/server embedded in some other application is not
particularly difficult, re-using the existing code.

     Andrew
