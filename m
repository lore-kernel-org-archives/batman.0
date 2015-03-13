Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 13 Mar 2015 13:02:33 +0100
Message-ID: <1501672.outaxq6BMD@bentobox>
In-Reply-To: <5502BBBF.2030801@gmail.com>
References: <1426158361-6090-1-git-send-email-anatoliy.lapitskiy@gmail.com>
 <5077509.urIbKZALzi@bentobox> <5502BBBF.2030801@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] Added "--update-script" flag for
	specifying a command for running when new data piece is receviced.
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
To: Anatoliy <anatoliy.lapitskiy@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Friday 13 March 2015 12:28:15 Anatoliy wrote:
[...]
> >> --- a/recv.c
> >> +++ b/recv.c
> >> @@ -40,7 +40,7 @@ static int finish_alfred_push_data(struct globals *globals,
> >>  				   struct ether_addr mac,
> >>  				   struct alfred_push_data_v0 *push)
> >>  {
> >> -	int len, data_len;
> >> +	int len, data_len, new_entry;
> >>  	struct alfred_data *data;
> >>  	struct dataset *dataset;
> >>  	uint8_t *pos;
> > Has anyone a better name for new_entry? I don't really like it because
> > it sounds to me like a variable that stores the pointer to a new object.
> "new_entry_created"?
> btw, it could be bool as it's just a flag. can I use <stdbool.h> from C99?

Yes, sounds good. I personally have nothing against bool.
(At least not at the moment)

[...]
> >> +
> >> +		if (globals->update_script && !list_empty(&globals->changed_data_types)) {
> >> +			/* call update script with list of datatypes_changed */
> >> +			char command[strlen(globals->update_script) + 7*globals->changed_data_type_count];
> > Please don't use variable length arrays.
> >
> > Please fix your spacing around operands.
> >
> > The calculation of the command length is complete bogus.
> Agree. it should be length of update_script + 4 * changed count (3 for data type as maximum is "255" + space) + 1 for NULL.
> I will add a comment about it.

Please don't forget the change of the datatype of data_type to really
have a range of 0-255.

I don't think the comment is important but we will see if it is helpful.

[...]
> >> +			int pid = fork();
> >> +			if (pid == 0) {
> >> +				system(command);
> > Why do you want to execute the command using the system shell? Maybe you
> > wanted to use something from the exec* family instead.
> In case if user will set shell script as "update-script" parameter, exec* won't work.
> Of course, I can add "sh", "-c" to exec* parameters, but what advantages this method will have then?

This was exactly the thing I wanted to know. If you really want to
support shell scripts then please update your manpage entry to
inform the user about this "feature". Otherwise he might
accidentally forget the required escaping or similar things.

Currently the manpage says that you can specify a path and not a
script which may be used to execute a file.

[...]
> >
> > Maybe there are more thing but I have to stop the review now.
> Again, thank you very much for review.
> Is there a link for code style used?

 * http://www.open-mesh.org/projects/open-mesh/wiki/Contribute#Submitting-patches
 * https://www.kernel.org/doc/Documentation/CodingStyle
 * the mood of the person reviewing the code

Kind regards,
	Sven
